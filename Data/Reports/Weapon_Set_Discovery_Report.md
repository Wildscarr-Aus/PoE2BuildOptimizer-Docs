# Weapon Set Discovery Report

**Phase:** 4D.7A — Weapon Set Discovery Investigation  
**Scan date:** 2026-10-19  
**Scan location:** `C:\Users\teamp\OneDrive\Documents\Path of Building (PoE2)\Builds`  
**Files scanned:** 38 XML files; all 38 parsed successfully  
**Distinct file contents:** 37; two Spin to Win Monk 0.5.5 files are byte-identical

## Executive Summary

The refreshed recursive scan found five XML files beyond the prior 33-file
snapshot. The additions materially extend the observed format: the corpus
now contains two builds with multiple `ItemSet` elements, one with seven,
and skill records whose `slot` is a swap slot.

Observed storage locations:

- Passive allocations are represented by `Tree/Spec/WeaponSet1/@nodes` and
  `Tree/Spec/WeaponSet2/@nodes`. Twelve builds have a `WeaponSet1` block and
  eleven have a `WeaponSet2` block; eleven have both and one has only
  `WeaponSet1`.
- Equipment configurations are represented by `Items/ItemSet/Slot`, where
  `@name` identifies the slot and `@itemId` references an `Items/Item`.
  Thirty-six builds have one `ItemSet`, one has two, and one has seven.
- `Items/@activeItemSet` selects an item-set ID. It resolves to an `ItemSet`
  in all 38 files. The selected ID is `1` in 37 builds and `2` in one.
- `Items/@useSecondWeaponSet` and each `ItemSet/@useSecondWeaponSet` are
  distinct observations. There is one build where the root value is
  `"false"` but one of its seven `ItemSet` values is `"true"`.
- `Skills/@activeSkillSet` is separate from `Items/@activeItemSet`; its
  selected value is `1` in 36 builds and `2` in two.
- `Skills/SkillSet/Skill/@slot` explicitly records values such as
  `Weapon 1`, `Weapon 2`, and their `Swap` slots. No attribute named
  `weaponSet` was found on `<Skill>` or `<Gem>`. A slot value is direct
  evidence of a skill-to-slot assignment, not proof that a slot maps to a
  numbered passive allocation block.

The exports therefore establish direct facts about allocation blocks,
item-set records, selected IDs, slots, and skill slot assignments. They do
not establish a universal semantic rule for `has_multiple_weapon_sets`, or
a mapping between skill slots and `WeaponSet1`/`WeaponSet2`. No importer,
optimizer, or Evidence Contract changes were made.

## Method and Definitions

- Recursively enumerated every `*.xml` file under the requested folder.
- Parsed every file with Python's XML parser; parse failures were recorded
  as failures, not skipped. None occurred.
- Counted comma-separated node IDs in each named passive allocation
  element, excluding empty tokens. Inventory counts are summed across a
  build's `Tree/Spec` elements.
- Counted `ItemSet` elements per build and matched
  `Items/@activeItemSet` to `ItemSet/@id`.
- Considered a requested weapon slot populated when its nonzero
  `@itemId` resolves to an `Items/Item` record in the selected item set.
- Recorded `useSecondWeaponSet` as literal XML strings at both the `Items`
  and `ItemSet` levels. The string `"nil"` was not coerced to a boolean or
  missing value.
- Counted `<Skill>` records by their literal `@slot` value and also counted
  the number of distinct builds containing each value.
- Identified literal item base labels from populated weapon-named slots
  across all item sets. The third nonempty item-text line was used only when
  it was not metadata such as `Spirit:` or `Unique ID:`. No broader weapon
  category was inferred from item text.
- Compared file SHA-256 hashes to identify duplicate XML contents.

For the inventory, the slot flags are ordered `Weapon 1`, `Weapon 2`,
`Weapon 1 Swap`, `Weapon 2 Swap`; `Y` means the selected `ItemSet` slot
resolves to an item. The literal label column shows item name and base-item
text where present. If the export has metadata rather than a base-item line,
that limitation is stated.

## Build Inventory

`ItemSet` values are summarized as `value x count`. The toggle column is
`Items/@useSecondWeaponSet / all ItemSet values`. Passive columns are
`block present / node count`. Active IDs are `activeItemSet / activeSkillSet`.

| Build XML | Class / ascendancy | ItemSets | Toggle: Items / ItemSet values | Active IDs: item / skill | WeaponSet1 | WeaponSet2 | Slots: W1, W2, W1 Swap, W2 Swap | Active-set item labels |
|---|---|---:|---|---|---|---|---|---|
| `aanewtest/Spin to Win Monk 0.5.5.xml` | Monk / Martial Artist | 1 | `false / false x1` | `1 / 1` | Yes / 16 | Yes / 15 | Y, N, Y, N | Duality / Warding Quarterstaff; Vivid Talons / Voltfang Talisman |
| `Amazon/farcuetwo.xml` | Huntress / Spirit Walker | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Phoenix Edge / Akoyan Spear; Plague Bane / Wrath Sceptre |
| `Amazon/Whirling twisters.xml` | Huntress / Amazon | 1 | `true / true x1` | `1 / 1` | Yes / 24 | Yes / 24 | Y, N, Y, Y | Skysliver / Winged Spear; Crit Chance, High DPS/Accuracy, Gem Levels / Akoyan Spear; Sacred Flame / Shrine Sceptre |
| `Druid/Druid pets.xml` | Druid / Shaman | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, N, N, N | Raven's Flock / Ashen Staff |
| `Druid/elemental weakness.xml` | Druid / Oracle | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Soul Spire / Dueling Wand; Dire Cry / Omen Sceptre |
| `Druid/End Game Fissure Bear.xml` | Druid / Shaman | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | The Flesh Poppet / Runeforged Vicious Talisman; Fate Song / Shrine Sceptre |
| `Druid/Firestorm Druid.xml` | Druid / Shaman | 1 | `nil / nil x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Fury of the King / Ashbark Talisman; Morbid Knell / Shrine Sceptre |
| `Druid/Leveling build.xml` | Druid / Shaman | 1 | `nil / nil x1` | `1 / 1` | No / 0 | No / 0 | Y, N, Y, N | Taryn's Shiver / Gelid Staff; Amor Mandragora / Runeforged Changeling Talisman |
| `Druid/Shaman Calamity.xml` | Druid / Shaman | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Sol Chant / Shrine Sceptre; Fury of the King / Ashbark Talisman |
| `Druid/Totem Arc Druid.xml` | Druid / Shaman | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Tempest Goad / Dueling Wand; Rage Smasher / Shrine Sceptre |
| `Druid/wildfirestorm.xml` | Druid / Shaman | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, Y, N | Fury of the King / Ashbark Talisman; Morbid Knell / Shrine Sceptre; Oblivion Shatter / Fortified Hammer |
| `Huntress/ritualist weaponset test.xml` | Huntress / Ritualist | 7 | `false / false x6, true x1` | `1 / 1` | Yes / 84 | Yes / 84 | Y, Y, N, N | Tangletongue / Forked Spear; Guiding Palm of the Eye / Shrine Sceptre |
| `Marauder/Arc totem.xml` | Mercenary / Gemling Legionnaire | 1 | `nil / nil x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Tempest Goad / Dueling Wand; Rage Smasher / Shrine Sceptre |
| `Marauder/Ashfurtitan.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Hysseg's Claw / Familial Talisman; Rift Gnarl / Shrine Sceptre |
| `Marauder/FR Arc Totems.xml` | Mercenary / Gemling Legionnaire | 1 | `nil / nil x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Loath Gnarl / Dueling Wand; Armageddon Crack / Shrine Sceptre |
| `Marauder/gemling 2 weaponset test 1.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | Yes / 24 | Yes / 24 | Y, N, Y, N | Brood Pole / Chiming Staff; Phoenix Core / Cannonade Crossbow |
| `Marauder/gemling firesmasher live.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Hysseg's Claw / Familial Talisman; Rift Gnarl / Shrine Sceptre |
| `Marauder/gemling firesmasher.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Sol Chant / Shrine Sceptre; Fury of the King / Ashbark Talisman |
| `Marauder/scarrarctot.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Tempest Goad / Dueling Wand; Rage Smasher / Shrine Sceptre |
| `Marauder/Totem Arc Gemling.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 2` | No / 0 | No / 0 | Y, Y, N, N | Tempest Goad / Dueling Wand; Rage Smasher / Shrine Sceptre |
| `Marauder/wildfireballer.xml` | Mercenary / Gemling Legionnaire | 1 | `false / false x1` | `1 / 1` | Yes / 5 | No / 0 | Y, Y, Y, N | Plague Thirst / Dueling Wand; Onslaught Song / Druidic Focus; Rage Pillar / Chiming Staff |
| `Marauder/wildspinning.xml` | Monk / Martial Artist | 1 | `false / false x1` | `1 / 1` | Yes / 16 | Yes / 15 | Y, N, Y, N | Duality / Runemastered Warding Quarterstaff; Vivid Talons / Voltfang Talisman |
| `Marauder/witchhunter weaponset test.xml` | Mercenary / Witchhunter | 2 | `false / false x2` | `2 / 2` | Yes / 69 | Yes / 84 | Y, Y, Y, N | Widowhail / Crude Bow; Drillneck / Penetrating Quiver; Atziri's Rule / Reflecting Staff |
| `Monk/Spin to Win Monk 0.5.5.xml` | Monk / Martial Artist | 1 | `false / false x1` | `1 / 1` | Yes / 16 | Yes / 15 | Y, N, Y, N | Duality / Warding Quarterstaff; Vivid Talons / Voltfang Talisman |
| `Monk/Spin to Win Monk.xml` | Monk / Martial Artist | 1 | `false / false x1` | `1 / 1` | Yes / 19 | Yes / 19 | Y, N, Y, N | Duality / Runemastered Warding Quarterstaff; Amor Mandragora / Changeling Talisman |
| `Ranger/Gastro Eruptus outofdate.xml` | Ranger / Pathfinder | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | N, N, N, N | No populated requested weapon slot |
| `Ranger/Lightning Endgame.xml` | Ranger / Deadeye | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Loath Thunder / Warmonger Bow; Phoenix Bolt / Visceral Quiver |
| `Ranger/new shockdeadeye.xml` | Ranger / Deadeye | 1 | `nil / nil x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Bramble Fletch / Rider Bow; Blight Impaler / Primed Quiver |
| `Ranger/pathfinder weaponset test.xml` | Ranger / Pathfinder | 1 | `true / true x1` | `1 / 1` | Yes / 24 | Yes / 24 | Y, Y, Y, Y | Maelstrom Gnarl / Stoic Sceptre; Honour Rock / Desert Buckler; Trenchtimbre / Spiked Club; Vengeance Knell / Stoic Sceptre |
| `Ranger/shocking_hood pre0.5.xml` | Ranger / Deadeye | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, Y, N | Dire Fletch / Obliterator Bow; Empyrean Barb / Volant Quiver; Precise Changeling Talisman of Absorption (next line is Unique ID metadata, no base line) |
| `Ranger/Shocking_hood.xml` | Ranger / Deadeye | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, Y, N | Dire Fletch / Obliterator Bow; Empyrean Barb / Volant Quiver; Precise Changeling Talisman of Absorption (next line is Unique ID metadata, no base line) |
| `Sorc/Lightning Spark.xml` | Sorceress / Stormweaver | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | N, N, N, N | No populated requested weapon slot |
| `Sorc/wildsparksorc.xml` | Sorceress / Stormweaver | 1 | `false / false x1` | `1 / 1` | Yes / 22 | Yes / 22 | Y, Y, Y, N | Rapture Barb / Dueling Wand; Entropy Barrier / Tasalian Focus; Maelstrom Pile / Chiming Staff |
| `Witch/abyssal lich weaponset test.xml` | Witch / Abyssal Lich | 1 | `false / false x1` | `1 / 1` | Yes / 24 | Yes / 24 | Y, N, Y, N | Dire Pile / Sanctified Staff; Cataclysm Roar / Chiming Staff |
| `Witch/chaoticwild pre0.5.xml` | Witch / Infernalist | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, N, N, N | The Unborn Lich / Ravenous Staff |
| `Witch/cold witch.xml` | Witch / Infernalist | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Rift Twine / Militant Bow; Glyph Flight / Primed Quiver |
| `Witch/Live shockitch outofdate.xml` | Witch / Lich | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Corpse Branch / Withered Wand; Victory Ram / Rattling Sceptre |
| `Witch/Spark Witch.xml` | Witch / Lich | 1 | `false / false x1` | `1 / 1` | No / 0 | No / 0 | Y, Y, N, N | Frosted Rattling Sceptre of Excitement (next line is Spirit metadata, no base line); Demon Pith / Antler Focus |

## Field Frequency Tables

### Corpus and Passive Allocation

| Field / observation | Count |
|---|---:|
| XML files scanned and parsed | 38 / 38 |
| Distinct XML contents | 37 |
| `Tree/Spec` elements | 50 |
| Builds with `WeaponSet1` | 12 |
| Builds with `WeaponSet2` | 11 |
| Builds with both blocks | 11 |
| Builds with `WeaponSet1` only | 1 |
| Builds with neither block | 26 |
| Node IDs listed in all `WeaponSet1/@nodes` blocks | 343 |
| Node IDs listed in all `WeaponSet2/@nodes` blocks | 350 |

Every build with a `WeaponSet2` block also has `WeaponSet1`. The two named
blocks were counted as serialized; no relationship to the general
`Tree/Spec/@nodes` list is inferred.

### Item Sets, Selectors, and Toggle Values

| Field / literal value | Count |
|---|---:|
| Builds with one `ItemSet` | 36 |
| Builds with two `ItemSet` elements | 1 |
| Builds with seven `ItemSet` elements | 1 |
| `Items/@activeItemSet = "1"` | 37 builds |
| `Items/@activeItemSet = "2"` | 1 build |
| Active item-set ID resolves to an `ItemSet` | 38 / 38 |
| `Skills/@activeSkillSet = "1"` | 36 builds |
| `Skills/@activeSkillSet = "2"` | 2 builds |
| `Items/@useSecondWeaponSet = "false"` | 31 builds |
| `Items/@useSecondWeaponSet = "true"` | 2 builds |
| `Items/@useSecondWeaponSet = "nil"` | 5 builds |
| `ItemSet/@useSecondWeaponSet = "false"` | 37 item sets |
| `ItemSet/@useSecondWeaponSet = "true"` | 3 item sets |
| `ItemSet/@useSecondWeaponSet = "nil"` | 5 item sets |
| Item-set toggle equals its containing `Items` toggle | 44 / 45 item sets |

The mismatch is `Huntress/ritualist weaponset test.xml`: the `Items` value
is `"false"`, while `ItemSet` ID `6` has `"true"` and its six other item
sets have `"false"`.

### Selected Item-Set Slot Population

| Slot | Populated | Empty or unresolved |
|---|---:|---:|
| `Weapon 1` | 35 | 3 |
| `Weapon 2` | 26 | 12 |
| `Weapon 1 Swap` | 15 | 23 |
| `Weapon 2 Swap` | 2 | 36 |

Counts apply only to the selected `ItemSet` in each build. A slot is
populated only when the nonzero item ID resolves to an item record.

### Skill Slot Values

| `Skills/SkillSet/Skill/@slot` literal | Skill records | Builds containing value |
|---|---:|---:|
| `Weapon 1` | 31 | 24 |
| `Weapon 2` | 23 | 17 |
| `Weapon 1 Swap` | 6 | 5 |
| `Weapon 2 Swap` | 2 | 2 |

Twenty-seven builds have at least one skill with one of these four slot
values. Record counts include multiple skill records in the same build.

### Distinct Literal Base-Item Labels

There are 43 distinct literal base-item labels in populated
weapon-named slots across all item sets. These are source strings, not
normalized weapon classes; slots can also contain off-hand items,
talismans, and quivers.

`Akoyan Spear`, `Antler Focus`, `Ashbark Talisman`, `Ashen Staff`,
`Cannonade Crossbow`, `Changeling Talisman`, `Chiming Staff`, `Crude Bow`,
`Desert Buckler`, `Druidic Focus`, `Dueling Wand`, `Familial Talisman`,
`Forked Spear`, `Fortified Hammer`, `Gelid Staff`, `Hardwood Spear`,
`Leather Buckler`, `Militant Bow`, `Obliterator Bow`, `Omen Sceptre`,
`Ornate Buckler`, `Penetrating Quiver`, `Primed Quiver`, `Rattling Sceptre`,
`Ravenous Staff`, `Reflecting Staff`, `Rider Bow`,
`Runeforged Changeling Talisman`, `Runeforged Vicious Talisman`,
`Runemastered Warding Quarterstaff`, `Sanctified Staff`, `Shrine Sceptre`,
`Spiked Club`, `Stoic Sceptre`, `Tasalian Focus`, `Visceral Quiver`,
`Volant Quiver`, `Voltfang Talisman`, `Warding Quarterstaff`,
`Warmonger Bow`, `Winged Spear`, `Withered Wand`, and `Wrath Sceptre`.

Two referenced item descriptions do not serialize a base-item line in the
expected position: the following line is `Unique ID:` metadata in one item
and `Spirit:` metadata in another. They were not counted as base-item
labels. No category mapping or correction was applied.

## Observed XML Patterns

1. **Passive allocation blocks are named separately.** `WeaponSet1` and
   `WeaponSet2` elements carry comma-separated `nodes` values. One build
   has only the former. Presence or absence is reported literally; absence
   is not interpreted as an empty allocation.
2. **Item-set configurations are explicit records.** `Items/ItemSet`
   contains the configuration's `Slot` references, and
   `Items/@activeItemSet` selects an ID. Multiple item sets are now
   observed in two builds. Their presence directly proves multiple
   serialized item-set records, but does not alone prove the gameplay
   meaning of `has_multiple_weapon_sets`.
3. **Swap equipment can be represented in the same slot structure.**
   `ItemSet/Slot/@name` values include `Weapon 1 Swap` and
   `Weapon 2 Swap`. The selected-set counts above describe only the active
   item set; other item sets may contain different slot contents.
4. **The second-set toggle has two levels and is not a universal
   indicator.** Its root value and per-item-set values match in 44 of 45
   item sets. The Ritualist test export has one per-item-set `"true"` value
   under a root `"false"` value. Across all records, the literal `"nil"`
   is also present and is not treated as false.
5. **Allocation blocks, toggles, and active swap-slot population do not
   coincide.** Cross-tab below uses the root `Items` toggle, any passive
   allocation block in the build, and whether either swap slot resolves to
   an item in the selected item set.

   | `Items/@useSecondWeaponSet` | Any allocation block | Active item set has a populated swap slot | Builds |
   |---|---|---|---:|
   | `false` | Yes | Yes | 9 |
   | `false` | Yes | No | 1 |
   | `false` | No | Yes | 3 |
   | `false` | No | No | 18 |
   | `true` | Yes | Yes | 2 |
   | `nil` | No | Yes | 1 |
   | `nil` | No | No | 4 |

6. **Active item-set and active skill-set selectors are separate.**
   `Items/@activeItemSet` selects an `ItemSet`; `Skills/@activeSkillSet`
   selects a `SkillSet`. Their observed values differ in some builds and
   are not mapped to each other here.
7. **A skill-to-slot field exists, but no numbered set field was found.**
   `Skills/SkillSet/Skill/@slot` explicitly contains `Weapon 1`, `Weapon 2`,
   and swap-slot values. No `<Skill>` or `<Gem>` has a `weaponSet`
   attribute. The scan does not establish that `Weapon 1 Swap` is
   equivalent to passive `WeaponSet2`, or any other slot-to-allocation
   mapping.
8. **Item text is not a normalized weapon taxonomy.** The 43 distinct
   literal base-item strings are useful inventory data, but should not be
   converted to weapon classes or gameplay behavior without an
   authoritative source.

## Candidate Indicators and Confidence Assessment

Confidence is assigned to the narrow stated observation. HIGH means the
serialized field directly supports that observation consistently in this
corpus; it does not automatically establish the broader gameplay meaning.

| Candidate observation | Supported conclusion | Confidence | Evidence and limitation |
|---|---|---|---|
| `Tree/Spec/WeaponSet1/@nodes` exists | The export records node IDs in the named `WeaponSet1` block | **HIGH** | Direct XML location; present in 12 builds. Does not establish how entries relate to general `Spec/@nodes`. |
| `Tree/Spec/WeaponSet2/@nodes` exists | The export records node IDs in the named `WeaponSet2` block | **HIGH** | Direct XML location; present in 11 builds. |
| Multiple `Items/ItemSet` records exist | The export contains multiple distinct item-set records | **HIGH** | Directly counted in two files (one has two records, one has seven). Whether these mean multiple weapon configurations is not established. |
| `ItemSet/Slot/@name` plus resolvable `@itemId` | A named item slot references that item record | **HIGH** | Direct join was checked. Does not prove active gameplay use unless the set is selected, nor a skill association. |
| `Items/@activeItemSet` | The exported selector names an `ItemSet` ID | **HIGH** | All 38 values resolve to an item set; only IDs 1 and 2 occur. |
| `Skills/@activeSkillSet` | The exported selector records a `SkillSet` ID | **HIGH** | Values 1 and 2 occur. No mapping to `activeItemSet` is established. |
| `Items/ItemSet/@useSecondWeaponSet` | The literal toggle is stored on item sets | **HIGH** | Present with literal values `false`, `true`, and `nil`; one value differs from its containing `Items` value. Broader semantics remain unresolved. |
| `Items/@useSecondWeaponSet = "true"` | The export records root toggle value `"true"` | **HIGH** | Direct observation in two builds. Interpreting it as a complete test for multiple weapon sets is not proven. |
| Any passive allocation block | The build includes at least one named weapon-set allocation block | **HIGH** | Directly observed in 12 builds. Interpreting it as proof of multiple usable equipment configurations is weaker. |
| Any populated swap slot in active item set | The selected item set references an item in a swap slot | **HIGH** | Direct item reference observation in 15 builds. This alone does not establish a complete second configuration. |
| `Skills/SkillSet/Skill/@slot` | A skill record has the stated weapon-slot value | **HIGH** | Direct field observed in 27 builds, including swap-slot values. Mapping that slot to `WeaponSet1/2` is unverified. |
| Any one of toggle, allocation block, or swap slot | The build has multiple weapon sets (`has_multiple_weapon_sets`) | **MEDIUM** | Each is a useful candidate signal, but the cross-tab shows they do not coincide and no single indicator is complete. Multiple item-set records directly show multiple item sets, not necessarily weapon-set semantics. |
| `Skill/@slot` contains `Weapon 1 Swap` or `Weapon 2 Swap` | The skill is associated with that literal swap slot | **HIGH** | The slot string is explicit. It does not establish an association with the numbered passive allocation block. |
| Skill or gem has an explicit `weaponSet` attribute | Direct skill-to-numbered-weapon-set mapping | **LOW** | No such attribute was found; the `slot` field is not treated as an equivalent mapping. |

No high-confidence universal indicator for the semantic claim
`has_multiple_weapon_sets` is established. High confidence applies to the
literal fields and their direct observations, not to unverified
relationships between them.

## Candidate Authoritative Sources

| Fact to observe | Source location | Scope and limits |
|---|---|---|
| Node IDs in a named allocation | `Tree/Spec/WeaponSet1/@nodes`, `Tree/Spec/WeaponSet2/@nodes` | Authoritative for the IDs serialized in that element. Do not infer the meaning of missing blocks or their relationship to general `Spec/@nodes`. |
| Item in a named equipment slot | `Items/ItemSet/Slot[@name=...]/@itemId`, joined to `Items/Item[@id=...]` | Authoritative for the serialized item reference. Select the relevant `ItemSet` before describing active-set equipment. |
| Selected item set | `Items/@activeItemSet` matched to `Items/ItemSet/@id` | Direct selection field. Multiple item sets occur in two files; broader activation behavior is not tested. |
| Selected skill set | `Skills/@activeSkillSet` matched to `Skills/SkillSet/@id` | Direct selection field, separate from the selected item-set field. |
| Literal second-set toggle | `Items/@useSecondWeaponSet` and `Items/ItemSet/@useSecondWeaponSet` | Preserve each literal and its location. Do not collapse root and per-set values; one build contains a mismatch. |
| Skill-to-slot assignment | `Skills/SkillSet/Skill/@slot` | Directly records slot strings, including swap slots. Does not directly name `WeaponSet1` or `WeaponSet2`. |
| Skill-to-numbered-set association | No direct field identified | No `weaponSet` attribute was found on `<Skill>` or `<Gem>`. No mapping should be inferred from slot names, active selectors, item content, or passive blocks. |

## Additional Sample Recommendations

The new exports improve coverage but leave semantic questions unresolved.
Collect **8 additional XML exports**, with controlled pairs where indicated:

| Count | Requested sample | Question addressed |
|---:|---|---|
| 2 | Independently configured builds with `Items/@useSecondWeaponSet="true"` from different weapon families, such as bow/quiver and caster or melee swaps | The corpus has two root-`true` builds; more independent examples are needed to assess that toggle's semantic coverage. |
| 4 | Two controlled before/after pairs changing a skill's `Skill/@slot` while holding other build data constant; include one `Weapon 1` to `Weapon 1 Swap` change and one `Weapon 2` to `Weapon 2 Swap` change | Tests whether slot assignment tracks skill configuration and whether it maps consistently to the passive allocation blocks. |
| 2 | Builds with multiple `ItemSet` records where only non-weapon equipment differs, with all weapon slots held constant | Tests whether multiple item sets can occur without multiple weapon configurations. |

**Current confidence:** HIGH for the presence and literal meaning of the
observed XML fields; MEDIUM for `has_multiple_weapon_sets` candidate
indicators; LOW for a skill-to-numbered-set mapping.

**Expected confidence after sampling:** Controlled pairs may strengthen or
disprove a slot-to-allocation mapping if the export changes consistently.
Additional `true` examples may improve understanding of the toggle but do
not guarantee a complete indicator. No sample count alone can establish
HIGH confidence if counterexamples remain or the format lacks an explicit
association field.

## Open Questions

1. Does `useSecondWeaponSet` control availability, calculation selection,
   or another behavior? Why can a per-item-set value differ from the root
   `Items` value?
2. What does the literal string `"nil"` mean in this export field?
3. How do `WeaponSet1/2/@nodes` relate to the general
   `Tree/Spec/@nodes` list?
4. Do `Skill/@slot` swap-slot values correspond to numbered passive
   allocation blocks, and if so, under what rules?
5. What distinguishes the seven `ItemSet` records in the Ritualist test
   export, and do they represent alternate equipment configurations,
   historical configurations, or another concept?
6. How should modified item text and records without a base-item line be
   classified using an authoritative item source?
7. Do these patterns hold consistently across PoB2 application versions
   and export histories?

## Final Recommendation

Use these exported fields only for facts they directly encode:

- `WeaponSet1/2/@nodes`: node IDs serialized in the named allocation block.
- `ItemSet/Slot/@name` and `@itemId`: the item reference for a named slot in
  a particular item set.
- `Items/@activeItemSet`: the selected item-set ID.
- `Skills/@activeSkillSet`: the selected skill-set ID.
- `Items` and `ItemSet` `@useSecondWeaponSet`: separate literal toggle
  values; retain their source locations and preserve `"nil"`.
- `Skills/SkillSet/Skill/@slot`: the skill record's literal slot assignment.

Do not equate toggle values, item-set count, swap-slot population,
active-set selectors, or passive allocation blocks. The skill slot field
is a direct association to a slot, but a mapping to `WeaponSet1/2` remains
unverified. Keep `has_multiple_weapon_sets` and
`weapon_set_association_observed` semantics unresolved until targeted
controlled exports establish the relationship. No producer mapping or
optimizer behavior is recommended by this discovery task.
