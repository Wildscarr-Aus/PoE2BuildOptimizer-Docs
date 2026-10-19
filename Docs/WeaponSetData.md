# Weapon-Set-Related Imported Data

## Purpose

The importer preserves weapon-set-related values that are explicitly
serialized in PoB2 XML. It does not assign game semantics to those values.
The format observations supporting this implementation are recorded in
[`Data/Reports/Weapon_Set_Discovery_Report.md`](../Data/Reports/Weapon_Set_Discovery_Report.md).

The shared reader is
`Src/Io/weapon_set_data_importer.py`; both `BuildImporter` and
`PoB2Importer` use it.

## XML Sources and Model Fields

### Passive allocation blocks

Source elements:

- `Tree/Spec/WeaponSet1/@nodes`
- `Tree/Spec/WeaponSet2/@nodes`

Each `Tree/Spec` produces a `WeaponSetAllocationModel` in
`BuildModel.weapon_set_allocations`, in document order. Each record stores:

- The spec's zero-based document index.
- Whether each named allocation block exists, independently of its
  `nodes` attribute.
- The exact raw `nodes` attribute value, or `None` when the attribute is
  absent.
- The comma-separated node ID tokens and their count.

For compatibility with existing consumers, the first spec's numeric IDs
also populate `PassiveTreeModel.weapon_set_1_nodes` and
`weapon_set_2_nodes`. These sets are convenience views and do not replace
the raw per-spec records.

### Items and item sets

Source elements and attributes:

- `Items` attributes, including `@activeItemSet` and
  `@useSecondWeaponSet`.
- Every `Items/ItemSet` and its attributes.
- Every `Items/ItemSet/Slot`, including its `@name` and `@itemId`.
- `Items/Item/@id` and item text used to resolve slot references.

`BuildModel.item_sets` contains every `ItemSet` in source order.
`BuildModel.item_set_count` is the number imported.
`BuildModel.active_item_set_id` preserves the literal selected ID, and
`BuildModel.selected_item_set` references the matching imported record when
one exists.

Each `ItemSetModel` preserves its ID, all XML attributes, the literal
`useSecondWeaponSet` value, and every slot as a `WeaponSlotModel`. Each
slot retains its literal name, item ID, original attributes, resolved
`ItemModel` reference (when found), and a `populated` flag. A slot is
populated only when its nonempty, nonzero item ID resolves to an item
record. This is a reference-resolution status, not an assertion about
gameplay use.

`BuildModel.items_attributes` preserves the `Items` element's attributes.
`BuildModel.items_use_second_weapon_set` preserves its root toggle
separately from every `ItemSetModel.use_second_weapon_set` value. Missing
attributes are represented as `None`; present strings such as `"true"`,
`"false"`, and `"nil"` remain literal strings.

### Skill sets and slot assignments

Source elements and attributes:

- `Skills/@activeSkillSet`
- Every `Skills/SkillSet/@id` and its attributes.
- `Skills/SkillSet/Skill/@slot` and other skill attributes.
- Child `Gem/@gemId`, `@skillId`, and `@variantId` values.

`BuildModel.skill_sets` contains all imported skill-set IDs and attributes.
`skill_set_count` reports their number; `active_skill_set_id` preserves the
literal active selector. For each skill record with a `slot` attribute,
`BuildModel.skill_slot_assignments` stores the parent skill-set ID, the
literal slot string, the skill attributes, and the directly serialized gem
identifiers.

The existing `BuildModel.skill_groups` behavior is unchanged: the legacy
import path continues to load its existing first-skill-set view. The new
`skill_sets` and `skill_slot_assignments` collections preserve metadata
from every skill set without changing that behavior.

## Explicit Non-Equivalences

No mapping or semantic inference is performed:

- **ItemSet != Weapon Set.** An `ItemSet` is stored as an item-set record;
  it is not relabeled as a weapon set.
- **SkillSet != Weapon Set.** A skill set is stored as a skill-set record.
- **Skill Slot != WeaponSet1/WeaponSet2.** Slot strings are preserved
  literally and are not mapped to passive allocation blocks.
- Toggle values, swap-slot contents, item-set count, active selectors, and
  passive allocation blocks are not combined into a derived
  `has_multiple_weapon_sets` value.
- No optimizer behavior, allocation relationship, or skill-to-numbered-set
  association is created.

## Known Limitations

- The model preserves values from the exported XML; it does not validate
  whether an exported item ID, skill identifier, or node ID is valid in
  game data.
- `populated` indicates only that a nonzero slot item ID resolves to an
  imported item record.
- The legacy numeric passive allocation sets are first-spec-only and
  unordered; use `weapon_set_allocations` for lossless per-spec text,
  presence, ordering, and counts.
- The legacy skill-group collection remains unchanged and is not a
  substitute for the all-skill-set slot-assignment records.
- This implementation does not serialize these additional fields through
  `BuildExporter`.
