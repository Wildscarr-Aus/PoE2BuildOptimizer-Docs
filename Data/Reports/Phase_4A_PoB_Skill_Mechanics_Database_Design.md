# Phase 4A - PoB Skill Mechanics Database
## Design Investigation

**Status:** Design complete; Phase 4A.1 mechanics database foundation implemented
**Scope:** Read-only review of the installed PoB2 skills data and current optimizer architecture  
**PoB data root reviewed:**  
`C:\Users\teamp\AppData\Roaming\Path of Building Community (PoE2)\Data`

No application code, tests, or installed PoB files were modified.

## Executive Summary

The installed `Data/Skills/` directory contains the mechanics layer missing
from the optimizer's compact `gems.lua` ingestion: skill type sets, support
eligibility requirements and exclusions, trigger flags, descriptions, and
calculation metadata. The current registry already has a priority-2
authoritative `skills` source rooted at the directory.

The recommended design is a version-aware, read-only `PoBSkillDatabase` that
indexes relevant skill records by the exact `skills["..."]` key. It should
expose structured, factual mechanics and retain unparsed/unknown data rather
than interpreting all Lua expressions as relationships. The GemDatabase's
`grantedEffectId` is the best first join from `SkillRecord.skill_id` to a
mechanics record. Gem entries' additional granted-effect IDs should also be
retained so a public gem can be connected to its internal support mechanics
record where PoB declares that mapping.

Possessing a trigger or support definition is not itself sufficient to claim
that one imported build skill triggers or supports another. High-confidence
edges require a compatible, enabled gem in the same applicable socket group
and explicit PoB mechanics proving the relevant compatibility. `ENABLES` and
`AMPLIFIES` need additional, typed effect/condition evidence; they should
remain unimplemented until that evidence is modeled.

## 1. Skills Directory Assessment

The reviewed directory contains nine Lua mechanics files plus
`SkillAssets.lua` and unrelated icon/texture assets. The following counts are
a lightweight census of top-level `skills[...]` assignments and common field
patterns in this installed snapshot; they are not a semantic parse or a
guarantee about other PoB versions.

| File | Approx. size | Top-level skill records | Primary contents | Relationship discovery | Later optimization |
|---|---:|---:|---|---|---|
| `act_dex.lua` | 704 KB | 64 | Dexterity active skills, skill types, descriptions, stats and effects | High | High |
| `act_int.lua` | 1,421 KB | 154 | Intelligence active/meta skills, trigger and curse definitions, effects | High | High |
| `act_str.lua` | 1,261 KB | 143 | Strength active skills, types, effects, and some trigger/meta records | High | High |
| `sup_dex.lua` | 195 KB | 162 | Dexterity support definitions and compatibility requirements | High | High |
| `sup_int.lua` | 359 KB | 206 | Intelligence support definitions and compatibility requirements | High | High |
| `sup_str.lua` | 277 KB | 220 | Strength support definitions and compatibility requirements | High | High |
| `minion.lua` | 103 KB | 52 | Generic/minion active skill records | Medium initially | High for minion analysis |
| `spectre.lua` | 316 KB | 260 | Monster/spectre skill definitions and implementation-specific actions | Low initially; useful for later companion/spectre work | High for advanced minion modeling |
| `other.lua` | 1,171 KB | 171 | Mixed active, triggered, hidden, item/tree-granted, and special skills | Medium, selectively | High, selectively |

`SkillAssets.lua` is an asset/icon lookup, not a mechanics authority for
relationships. The `.dds.zst` files are presentation resources and should be
ignored by the initial mechanics loader.

### Initial ingestion scope

Start with `act_dex.lua`, `act_int.lua`, `act_str.lua`,
`sup_dex.lua`, `sup_int.lua`, and `sup_str.lua`, plus only those records in
`other.lua` that are directly referenced by imported gem metadata. Add
`minion.lua` when minion mechanics are in scope. Defer the broad `spectre.lua`
record set, stat calculation internals, display assets, and unrelated
tree/item-granted records until a concrete consumer requires them.

The files are GGG-generated, read-only assets. The optimizer may inspect and
parse them, but must not modify, patch, or overwrite them.

## 2. Mechanics Inventory

| Category | Example source and record | Available information | Reliability and caveats |
|---|---|---|---|
| Skill types | `act_int.lua`, `skills["MetaCastOnCritPlayer"]`: `SkillType.Meta`, `SkillType.Triggers`, `SkillType.GeneratesEnergy`; `act_int.lua`, `skills["FrostBombPlayer"]`: `SkillType.Spell`, `SkillType.Triggerable` | Named mechanics types on a skill record | High as a statement of PoB's model for that installed version. It does not prove a particular build configuration or combat event. |
| Support identity | `sup_int.lua`, `skills["SupportBoundlessEnergyPlayerTwo"]`: `support = true` | Identifies a support mechanics record | High as record metadata. A support flag alone does not identify which imported gem it supports. |
| Support requirements | Same Boundless Energy II record: `requireSkillTypes = { SkillType.GeneratesEnergy, }` | Required target skill types | High when parsed with the original expression structure. Requirements may include boolean operators such as `AND`/`OR`; flattening into a set loses meaning. |
| Support additions/exclusions | Support records contain `addSkillTypes` and `excludeSkillTypes`; the hidden `SupportMetaCastOnCritPlayer` record adds `Triggered` and excludes `InbuiltTrigger` | Compatibility modifications and excluded skill types | High for the declared rules if the full expression and target semantics are preserved. Empty fields are meaningful and must not be confused with absent/unparsed fields. |
| Trigger mechanics | `act_int.lua`, `MetaCastOnCritPlayer`: `SkillType.Triggers`, description states it gains Energy on critical hits and triggers socketed Spells at maximum Energy. Its internal `SupportMetaCastOnCritPlayer` requires `Spell` and `Triggerable` and has `isTrigger = true` | Trigger-provider and eligible-target evidence | High for the mechanic declaration and its declared compatibility; it does not prove activation frequency, damage, or that every same-group gem is eligible. |
| Meta skills | `MetaCastOnCritPlayer` has `SkillType.Meta`; `gems.lua` links the public gem to internal granted effects (including `SupportMetaCastOnCritPlayer`) | Meta status and public-gem-to-mechanics mapping | High for explicit IDs and type declaration. Treat additional granted effects as linked mechanics records, not as extra imported gems. |
| Curse mechanics | `ElementalWeaknessPlayer` description says it curses targets and its type set includes `SkillType.AppliesCurse` | Skill-level ability to apply a curse | High for that declared capability; not proof that the curse is applied to or benefits another build skill. |
| Herald mechanics | `HeraldOfIcePlayer` and `HeraldOfThunderPlayer` include `SkillType.Herald`; descriptions describe conditional enemy/attack events | Herald type and human-readable event behavior | High for the type/description as authored. Descriptions are prose; converting them into precise machine conditions requires a separate reviewed rules representation. |
| Minion/companion mechanics | Generic `SummonBeastPlayer` data from `gems.lua` resolves to `gemType=Minion`, tag `companion`; `act_*` and `minion.lua` hold skill mechanics | Generic summon/minion classification and associated skills | High for the generic gem facts. A build's `Companion: Frozen Mandibles` label is a selected variant/name not present as a literal gem catalog name; mapping that to the actual companion entity requires additional build/item/variant decoding. |
| Spectre mechanics | `spectre.lua` contains many monster skill records | Monster action records that may become useful for specific spectres | High only for each exact record; association to an imported gem/companion is not generally established by the presence of the file. |
| Optimization data | Many skill records include `statSets`, `statMap`, `baseFlags`, `constantStats`, `stats`, level tables, weapon restrictions, costs and cooldowns | Skill-specific calculation and constraints | Potentially high when reproduced with PoB's calculation semantics. Raw expressions are not ready-to-score numeric facts. |

### Version-specific census

This installed snapshot had approximately 64/154/143 records in the three
active-skill files and 162/206/220 records in the three support files. A
text-pattern census found `support = true` on approximately 155/183/202
records in `sup_dex.lua`, `sup_int.lua`, and `sup_str.lua` respectively.
It found `requireSkillTypes` and `excludeSkillTypes` in approximately the
same respective counts, and trigger markers (`isTrigger = true`) in the
active files. Counts can shift as PoB updates and are useful for loader
coverage checks, not gameplay logic.

## 3. Proposed PoBSkillDatabase Architecture

### Responsibilities

`PoBSkillDatabase` should:

1. Resolve the installed skills directory through
   `registry.path("skills")`.
2. Read a deliberately scoped set of skill-definition files without changing
   them.
3. Parse and normalize factual mechanics fields while preserving source file,
   source key, source version/context, and unparsed status.
4. Index records by exact mechanics key (`skills["..."]`), retaining
   duplicate keys as a list rather than overwriting.
5. Provide stable lookup/query APIs. It must not create relationship edges,
   contributor roles, or damage conclusions.

### Proposed record model

The model should distinguish values that are parsed, absent in source, and
present but not understood. A possible conceptual record:

```text
PoBSkillRecord
    mechanics_id: str
    name: str | None
    source_file: str
    source_version: str | None
    hidden: bool | None
    support: bool | None
    is_trigger: bool | None
    cannot_be_supported: bool | None
    skill_types: set[str] | None
    require_skill_types: expression | None
    add_skill_types: set[str] | None
    exclude_skill_types: set[str] | None
    gem_family: list[str] | None
    description: str | None
    stat_sets: raw_or_deferred_payload | None
    parse_status: parsed | partial | unsupported
    unparsed_fields: list[str]
```

Preserve the difference between `None` (not supplied or not parsed) and an
empty collection explicitly declared by PoB. Preserve boolean grouping and
operators in requirements; do not reduce `AND`/`OR` expressions to an
unordered set. Store free-text descriptions as source text, not as parsed
relationship facts.

The model need not ingest full `statMap` and level calculations in the first
release. Keep a raw/opaque payload or explicitly mark those fields deferred;
never claim the database understands calculations it has not interpreted.

### Lookup API

Suggested APIs:

```text
get_by_granted_effect_id(identifier) -> PoBSkillRecord
get_all_by_granted_effect_id(identifier) -> list[PoBSkillRecord]
get_skill_types(identifier) -> set[str] | None
get_support_requirements(identifier) -> expression | None
get_support_exclusions(identifier) -> set[str] | None
get_trigger_requirements(identifier) -> expression | None
```

The exact ID lookup should either return a unique record or expose ambiguity
explicitly. Avoid a last-record-wins mechanics index. Convenience query
methods should be views over the record, not an alternate source of
interpretation.

Support rules can be stored on the support's internal mechanics record. The
system may additionally expose a separate linked-gem view that joins a
GemDatabase record to its primary and additional granted-effect IDs.

### Loading and parsing

These files are not Lua table literals like `gems.lua`. They are chunks with
headers such as `local skills, mod, flag, skill = ...`, assignment statements
such as `skills["FrostBombPlayer"] = { ... }`, references like
`SkillType.Spell`, and nested function calls/expressions in calculation
tables. `slpp.decode()` of the entire file is therefore not an established
parser strategy.

Recommended parser stages:

1. Build a bounded parser for the relevant `skills["id"] = { ... }` records,
   tracking Lua strings, comments, braces, nested tables, and supported
   literals.
2. Parse the mechanics fields required for identity/relationship readiness
   first (`skillTypes`, support flags, requirement/addition/exclusion fields,
   trigger flags, `cannotBeSupported`, and identity linkage).
3. Preserve unknown expressions as opaque source text and report partial
   parsing. Fail explicitly on malformed boundaries; do not silently emit
   incomplete compatibility rules as complete.
4. Add parser fixtures from installed files and coverage assertions for known
   mechanics records. Keep the parser read-only and data-version-aware.

Executing PoB's Lua chunks inside the optimizer is not recommended as the
initial approach: these chunks assume PoB runtime functions and enums (`mod`,
`flag`, `skill`, `SkillType`, and others), which are not standalone data
files.

### Caching and registry integration

The existing registry already defines `skills` as a priority-2 authoritative
source, join key `grantedEffectId`, consumed by `SkillRelationshipResolver`.
Use `registry.path("skills")`; do not construct an installed-data path
independently.

Load lazily once per `PoBSkillDatabase` instance, then cache immutable
normalized records. If cross-instance or persistent caching is later needed,
scope the cache to the resolved installed-data root and version/content
fingerprint; never reuse mechanics data across PoB versions silently.
Expose the source root/version and loaded-file list in diagnostic/report
metadata so stale or partial datasets are diagnosable.

## 4. Join Strategy

### Preferred joins

1. `SkillRecord.skill_id` (the XML `skillId`) ↔ `GemDatabase.grantedEffectId`
   identifies the public gem record.
2. The gem's primary `grantedEffectId` ↔ `skills["<mechanics_id>"]` is the
   preferred mechanics join.
3. Each explicit additional granted-effect ID on the gem record should be
   retained and joined to its own mechanics record. This is important for
   meta gems whose compatibility logic is encoded in an internal support
   record.

For example, Cast on Critical has public mechanics under
`MetaCastOnCritPlayer` and an internal trigger-support record
`SupportMetaCastOnCritPlayer`. `Boundless Energy II` resolves through
`SupportBoundlessEnergyPlayerTwo`.

### Fallbacks and ambiguity

- XML `gem_id` ↔ GemDatabase `gameId`, followed by the catalog's
  `grantedEffectId` and additional granted-effect IDs, is an acceptable
  fallback when the XML `skill_id` is absent or does not resolve.
- XML `variant_id` ↔ GemDatabase `variantId` can identify the catalog gem,
  after which mechanics joins use the catalog IDs.
- Name is a last resort only. Require a unique normalized catalog match,
  then use that record's IDs. Do not join mechanics records by display name.
- If a key maps to multiple mechanics records, return an explicit ambiguity
  result containing source files; do not choose one arbitrarily.
- If a PoB mechanics ID is referenced by no parsed skill record, retain the
  catalog link and mark mechanics metadata missing/unsupported rather than
  fabricating a record.

### Version concerns

`gems.lua` and `Data/Skills/` must be read from the same installed PoB root
and treated as a coherent snapshot. The registry's `skills` entry currently
points to the installed directory; it does not itself prove that a build's
historical XML was authored against that exact game/PoB version. Record the
installed source root/version and surface mismatches. Do not let build target
version silently select a different mechanics database.

## 5. Relationship Readiness Matrix

| Proposed edge | Data required for high-confidence edge | Possible but insufficient evidence | Initial readiness |
|---|---|---|---|
| `TRIGGERS` (trigger provider → eligible skill) | Trigger-provider mechanics record; explicit mapping from the public gem to internal trigger record; same applicable socket group; target's `Triggerable` type; required-type expression satisfied; exclusions such as `InbuiltTrigger` false; enabled state; appropriate group configuration | `trigger` gem tag, `SkillType.Triggers` alone, same group alone, target `Triggerable` alone, or `includeInFullDPS` | Ready for a narrow deterministic compatibility candidate once all fields and boolean rules parse. Does not prove actual runtime activation or damage. |
| `SUPPORTS` (support gem → supported skill) | Support record; same applicable group; support requirements satisfied against target skill types; excluded types absent; target is supportable; gem/support linkage exact; enabled state | `gemType=Support`, `support` tag, display description, or co-location | Strongly ready for explicit requirement/exclusion checks. Preserve direction expected by current consumers. |
| `ENABLES` (mechanic → skill/effect) | Explicit declared dependency or structured mechanic rule identifying both the enabling condition/effect and target; condition scope and endpoints represented | Same-group relation, tags, textual mention, or two related skill types | Not generally ready from generic support/skill type fields alone; keep unknown until explicit mechanic metadata exists. |
| `AMPLIFIES` (effect/source → affected target) | Parsed modifier/effect scope, modifier operation, target domain, conditions, and a verified target association | Damage or element tags, `payoff`, generic stat-map presence, or group co-location | Not ready for broad inference. Defer to a later modifier/effect model. |
| `APPLIES_CURSE` / `APPLIES_DEBUFF` (skill → effect) | Explicit `AppliesCurse` type and/or structured curse metadata, with target and effect identity where available | `curse` tag or description alone | The skill-to-capability fact is ready; linking the curse to another skill's damage is not. |
| `CONDITIONALLY_INTERACTS_WITH` (event/effect ↔ skill/event) | Structured condition, event trigger, affected skill/event, and scope from mechanics data | Description prose or herald tag | Potential-interaction records only until the prose/conditions are modeled and validated. |
| `USES_COMPANION` (build/skill → selected companion entity) | Build XML or item/variant data identifies the selected companion entity and maps it to the generic summon skill | `companion` tag or a display name containing a companion species | Not ready from the generic gem record alone. |

### Proven, possible, unknown

- **Proven mechanic:** PoB data explicitly states a property or compatibility
  rule for an exact mechanics ID.
- **Possible build edge:** a proven rule's prerequisites appear to hold in
  the imported configuration, but an in-game state/event may still be needed.
- **Unknown:** identity, co-membership, broad tags, DPS inclusion, or prose
  alone does not meet the edge's evidence threshold.

Current downstream behavior makes this distinction important:
`DamageChainResolver` promotes the target of every `TRIGGERS` relationship
without checking confidence. Until that consumer is confidence/evidence-aware,
only deterministic, compatibility-checked edges should be passed as
`TRIGGERS`; potential edges should use a separate non-semantic record/view
that the resolver cannot accidentally promote.

## 6. Real Build Validation Examples

### Whirling Twisters

Build: `Builds\Amazon\Whirling twisters.xml`  
Primary skill: **Twister**  
Active socket group 5: `mainActiveSkill=1`, `includeInFullDPS=true`, enabled.

Members:

| Gem | Mechanics facts available from installed data | What a database would expose |
|---|---|---|
| Cast on Critical | `MetaCastOnCritPlayer` has `Meta`, `Triggers`, and `GeneratesEnergy`; description says it triggers socketed Spells at maximum Energy. Internal `SupportMetaCastOnCritPlayer` requires `Spell` and `Triggerable`, adds `Triggered`, excludes `InbuiltTrigger`, and has `isTrigger=true`. | Public trigger/meta skill types and linked internal trigger compatibility record. |
| Profane Ritual | `ProfaneRitualPlayer` has `Spell`, `Triggerable`, `DamageOverTime`, `CreatesGroundRune`, and other types. | Target eligibility facts; no activation fact by itself. |
| Boundless Energy II | `SupportBoundlessEnergyPlayerTwo`, `support=true`; requirement `GeneratesEnergy`; description states it supports Meta Skills and those skills generate Energy faster. | Exact support target requirement and support identity. |
| Elemental Weakness | `ElementalWeaknessPlayer` has `AppliesCurse`; description says it lowers elemental resistances. | Curse capability and skill types; no link to a particular damage skill by itself. |
| Frost Bomb | `FrostBombPlayer` has `Spell`, `Triggerable`, `Damage`, `GeneratesInfusion`, `GeneratesRemnants`, and other types; description says it applies exposure and detonates for cold damage. | Trigger-eligibility facts plus skill mechanics. |
| Flame Wall | `FlameWallPlayer` has `Spell`, `Triggerable`, `DamageOverTime`, `CausesBurning`, and other types; its description says projectiles fired through it gain added fire damage. | Trigger-eligibility facts and a possible projectile interaction that requires a separate typed effect model. |

These records would make compatibility evaluation possible. They do not,
alone, prove actual casts or effects in combat. The build's group membership,
enabled flags, and exact IDs provide the configuration context a later
relationship resolver needs. `includeInFullDPS=true` must not be propagated
as per-gem damage evidence.

The current graph still produces `UNKNOWN` member-to-primary edges and the
current damage chain selects `Cast on Critical` as a candidate because it is
the first/main active gem in a full-DPS group. The database supplies mechanics
facts; it must not change that selection itself.

### Spin to Win Monk

Build: `Builds\Monk\Spin to Win Monk 0.5.5.xml`  
Primary skill: **Whirling Assault**.

Herald of Ice is the main active gem in enabled, full-DPS group 10 with Cold
Attunement and Poison III. Herald of Thunder is the main active gem in
enabled, full-DPS group 11 with Blind II and Elemental Armament II.

Their installed definitions identify both as `Herald` types and their
descriptions state conditional event behavior. Herald of Ice describes an
icy explosion after shattering an enemy with a non-Herald Attack Hit; Herald
of Thunder describes lightning bolts after killing Shocked enemies with a
non-Herald Attack Hit. The mechanics database would make those type and
condition facts inspectable. It would not prove those conditions happen in
this build, nor should it create a `Whirling Assault → Herald` trigger edge.

### Companion: Frozen Mandibles

The build XML label is `Companion: Frozen Mandibles`, but its IDs resolve to
generic catalog record `Companion: {0}` / `SummonBeastPlayer`. That catalog
record is `gemType=Minion` with `companion` and `minion` tags. The `minion.lua`
and `spectre.lua` data can supply associated minion/monster mechanics, but
the selected species mapping is not established by the generic gem record.
The database should expose generic summon mechanics while preserving the
build's display label separately; it should not claim the selected companion
record was resolved until a reliable variant/selection source is identified.

## 7. Risk Assessment

| Work | Risk | Assessment |
|---|---|---|
| Registry-backed file discovery and inventory | Low | The registry already supplies the installed `skills` directory. Read-only file enumeration and version/source reporting are isolated. |
| Mechanics parsing and record indexing | Medium | Lua syntax is nested, expression-rich, and split across files. A bounded parser must preserve unknown values, report partial coverage, and handle duplicate IDs. |
| `SkillIdentity` mechanics attachment | Medium | Exact ID joining is a contained enrichment, but public and internal granted effects need a clear representation. Avoid changing identity selection or interpretation. |
| Relationship generation | High | Requires compatibility expression evaluation, socket-group context, evidence/provenance, confidence semantics, endpoint identity, and downstream confidence gates. |
| Damage-chain/contributor integration | High | Trigger edges currently promote damage sources regardless of confidence; contributor mapping assumes fixed types/directions and name-based endpoints. |
| Optimization from stat maps | High | PoB calculation expressions, conditions, levels, and modifier scopes cannot safely be treated as static numeric data. Defer. |

### Safe first implementation

Safely implement source discovery, a read-only parser for an explicitly
limited set of factual fields, mechanics ID indexes, and diagnostic coverage
reports. Keep results detached from relationship generation. Then add
optional identity enrichment that attaches mechanics facts without affecting
selection, relationship output, or damage-chain behavior.

Keep relationship inference, conditional interaction rules, contributor
changes, and optimization scoring design-only until evidence/provenance and
downstream confidence gates are specified and tested.

## 8. Recommended Implementation Order

1. **Confirm data contract — complete:** source root, mechanics fields,
   missing/duplicate ID behavior, and content-fingerprint diagnostics are
   documented.
2. **Add parser fixtures and census — complete:** fixtures cover active and
   support records, comments, nested expressions, opaque Lua expressions,
   malformed boundaries, and duplicate IDs; the installed mechanics files
   were counted read-only.
3. **Implement `PoBSkillDatabase` — foundation complete:** registry path,
   mechanics records, ID indexes, deterministic ambiguity handling, lazy
   instance loading, coverage, and source fingerprint diagnostics.
4. **Validate exact joins:** public gem `grantedEffectId` and additional
   granted effects to mechanics records; verify Cast on Critical and
   Boundless Energy II linkage. Keep display-name joins out of mechanics
   indexing.
5. **Optionally expose factual mechanics on identity records:** no roles,
   classification, edges, selection changes, or damage-chain effects.
6. **Review coverage on real builds:** Whirling Twisters and Spin to Win;
   report what parsed and what remains unsupported, without changing
   current relationship outputs.
7. **Begin Relationship Discovery 2.0 only as a separate milestone:** define
   typed evidence, compatibility checks, conditional-vs-confirmed records,
   confidence gates, and consumer migration before generating semantic
   edges.
8. **Defer optimization ingestion:** design the calculation interpreter and
   parity validation with PoB separately; do not score from raw `statMap`
   strings.

## Phase 4A.1 Implementation Record

Implemented in `Src/Io/pob_skill_database.py`:

- Lazy, read-only loading through `registry.path("skills")`; all top-level
  mechanics Lua files are included except `SkillAssets.lua`.
- `PoBSkillMechanicsRecord` exposes exact skill IDs, source file/line,
  names/descriptions, explicit skill types, support flags, trigger flags,
  and support requirement/addition/exclusion expressions.
- Exact ID lookup preserves duplicate records. The unique lookup raises an
  explicit ambiguity error instead of choosing one.
- Requirements and exclusions remain source expressions; the loader does
  not evaluate Lua or infer relationships. Skill-type tables are normalized
  only when their syntax is fully recognized, while raw source and parse
  coverage remain available for unsupported syntax.
- Coverage reports loaded files, record and duplicate-ID counts, and field
  coverage. Diagnostics include the registered source root and a SHA-256
  fingerprint over the loaded filenames and contents. The fingerprint
  identifies the exact data snapshot; it is not a claimed PoB release number.
- The `skills` registry entry now lists `PoBSkillDatabase` as a consumer.

Validation against the installed snapshot loaded 1,439 records from nine
mechanics files, indexed 1,436 unique IDs, and surfaced three duplicate IDs.
The Cast on Critical, Frost Bomb, and Boundless Energy II records resolved by
their exact PoB mechanics IDs. No unsupported literal fields were encountered
in that snapshot. These are snapshot-specific counts, not invariants for
other PoB installations.

Relationship discovery, skill identity enrichment, damage-chain behavior,
contributors, and optimization were not changed.

## Reviewed Sources

Repository sources:

- [`pob_data_sources.py`](../../Src/Core/Versioning/pob_data_sources.py) -
  authoritative registry entries; `skills` is priority 2 and keyed by
  `grantedEffectId`.
- [`pob_data_registry.py`](../../Src/Core/Versioning/pob_data_registry.py) -
  registry path lookup; it resolves paths but does not parse data.
- [`gem_loader.py`](../../Src/Io/gem_loader.py) - current gem catalog
  indexes and ID lookup APIs.
- [`skill_signature.py`](../../Src/Audit/skill_signature.py) - XML extraction
  of skill groups, flags, gem IDs and names.
- [`skill_identity.py`](../../Src/Analysis/skill_identity.py) - flattened
  skill records and gem metadata join.
- [`skill_relationships.py`](../../Src/Analysis/skill_relationships.py) -
  current relationship model and conservative resolver.
- [`damage_chain_resolver.py`](../../Src/Analysis/damage_chain_resolver.py)
  and [`contributor_builder.py`](../../Src/Analysis/contributor_builder.py) -
  downstream handling of relationship types.

Installed PoB2 data reviewed (read-only):

- `Data\Skills\act_dex.lua`, `act_int.lua`, `act_str.lua`
- `Data\Skills\sup_dex.lua`, `sup_int.lua`, `sup_str.lua`
- `Data\Skills\minion.lua`, `spectre.lua`, `other.lua`
- `Data\Gems.lua`
- `Builds\Amazon\Whirling twisters.xml`
- `Builds\Monk\Spin to Win Monk 0.5.5.xml`
