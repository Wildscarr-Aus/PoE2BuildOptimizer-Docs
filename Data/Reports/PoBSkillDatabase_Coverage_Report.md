# PoBSkillDatabase Coverage Audit

**Audit date:** 2026-10-18  
**Database:** `PoBSkillDatabase`  
**Source root:** `C:\Users\teamp\AppData\Roaming\Path of Building Community (PoE2)\Data\Skills`  
**Source fingerprint (SHA-256):** `cd6d9d637c7efc048d7db40909a5cc063f8387f00f576d0ac97a46ce6a730ca6`

## Scope and counting rules

The audit includes every mechanics record loaded from the nine top-level
mechanics Lua files. It excludes `SkillAssets.lua`, which is an asset lookup,
not a skill mechanics file. One record is one `skills["..."]` assignment;
duplicate IDs therefore remain separate records.

Field coverage is based on usable source facts:

- **Skill ID:** the non-empty key in `skills["..."]`.
- **Base skill name:** a non-empty literal `name` value.
- **Types:** a present `skillTypes` table successfully parsed into its
  declared `SkillType` values. No records in this snapshot declare an empty
  type set.
- **Support requirements / exclusions:** the corresponding field is present
  in the mechanics record. An explicitly empty table counts as present;
  expressions are preserved as source text and are not evaluated.
- **Trigger metadata:** either an explicit `isTrigger` field or at least one
  of `SkillType.Triggers`, `SkillType.Triggered`, `SkillType.Triggerable`,
  or `SkillType.InbuiltTrigger`. This indicates declared trigger-related
  metadata, not an inferred build relationship.
- **Source file:** the Lua filename from which the record was loaded.
- **Unparseable record/field:** one of the modeled literal fields
  (`name`, `description`, `skillTypes`, `support`, `isTrigger`, or
  `cannotBeSupported`) is present but not understood by the bounded parser.
  Compatibility expressions such as `requireSkillTypes` are deliberately
  retained raw, not treated as parse failures.

## Dataset summary

| Measure | Count |
|---|---:|
| Loaded mechanics records | 1,439 |
| Loaded mechanics files | 9 |
| Unique mechanics IDs | 1,436 |
| IDs declared more than once | 3 |
| Unsupported modeled-field occurrences | 0 |
| Records containing an unsupported modeled field | 0 |

### Records by source file

| Source file | Records | Share of corpus |
|---|---:|---:|
| `act_dex.lua` | 64 | 4.45% |
| `act_int.lua` | 154 | 10.70% |
| `act_str.lua` | 143 | 9.94% |
| `minion.lua` | 53 | 3.68% |
| `other.lua` | 174 | 12.09% |
| `spectre.lua` | 260 | 18.07% |
| `sup_dex.lua` | 162 | 11.26% |
| `sup_int.lua` | 206 | 14.32% |
| `sup_str.lua` | 223 | 15.50% |
| **Total** | **1,439** | **100.00%** |

## Field coverage

Percentages in the main table use all 1,439 loaded records as the denominator.
“Missing” means the usable fact described in the counting rules is absent.

| Field | Records with field | Coverage | Missing records |
|---|---:|---:|---:|
| Skill ID | 1,439 | 100.00% | 0 |
| Base skill name | 1,431 | 99.44% | 8 |
| Skill types (parsed) | 842 | 58.51% | 597 |
| Support requirements (field declared) | 597 | 41.49% | 842 |
| Support exclusions (field declared) | 597 | 41.49% | 842 |
| Trigger metadata (combined definition above) | 455 | 31.62% | 984 |
| Source file | 1,439 | 100.00% | 0 |

The 597 records with `support = true` all declare both support-rule fields:

| Support-specific field | Present among support records | Coverage | Missing |
|---|---:|---:|---:|
| `requireSkillTypes` | 597 / 597 | 100.00% | 0 |
| `excludeSkillTypes` | 597 / 597 | 100.00% | 0 |

The corpus also contains 17 explicit `isTrigger = true` declarations. This
is a narrower measure than the combined trigger-metadata count; many skills
declare trigger-related types without an `isTrigger` field.

## Duplicate IDs

All duplicate IDs found in this snapshot are listed below. Each occurs twice;
unique lookup should report ambiguity rather than select one declaration.

| Mechanics ID | Declarations | Source locations |
|---|---:|---|
| `MASKelpDregCrossbow` | 2 | `spectre.lua:3525`, `spectre.lua:7901` |
| `MPWKelpDregPuncture` | 2 | `spectre.lua:6013`, `spectre.lua:8075` |
| `SupportOisinsOathPlayer` | 2 | `sup_int.lua:7211`, `sup_int.lua:7241` |

## Unparseable records and missing modeled fields

No records contained an unparseable modeled literal field in this snapshot.
The parser retained and understood all populated `name`, `description`,
`skillTypes`, `support`, `isTrigger`, and `cannotBeSupported` literals it
encountered. The top unparseable-record list is therefore empty.

There are eight records whose `name` field is the empty string. These are
missing base skill names, not parser failures:

| Mechanics ID | Source location |
|---|---|
| `MirageArcherSpawnPlayer` | `act_dex.lua:5141` |
| `LingeringIllusionSpawnPlayer` | `act_int.lua:14586` |
| `MirageDeadeyeSpawnPlayer` | `other.lua:11525` |
| `VoltaicBarrierTriggeredChainLightningPlayer` | `other.lua:20492` |
| `EDSPyramidHandLightningLance` | `spectre.lua:863` |
| `GASaltGolemMelee` | `spectre.lua:1538` |
| `SkelemancerSkelenado` | `spectre.lua:6712` |
| `TriggeredChargedMarkPlayer` | `sup_dex.lua:1005` |

Support compatibility expressions are kept as raw Lua source by design.
This audit does not claim those expressions have been semantically evaluated.

## Sample records

| Mechanics ID | Source | Base name | Parsed types / mechanics facts |
|---|---|---|---|
| `MetaCastOnCritPlayer` | `act_int.lua:2056` | Cast on Critical | Includes `Meta`, `GeneratesEnergy`, and `Triggers`; no explicit `isTrigger` field. |
| `FrostBombPlayer` | `act_int.lua:9025` | Frost Bomb | Includes `Spell` and `Triggerable`; not evidence that a build triggers it. |
| `SupportMetaCastOnCritPlayer` | `act_int.lua:2178` | `SupportMetaCastOnCritPlayer` | `support = true`, `isTrigger = true`; the internal trigger-support record has no `skillTypes` field. |
| `SupportBoundlessEnergyPlayerTwo` | `sup_int.lua:1074` | Boundless Energy II | `support = true`; requirement is retained as `{ SkillType.GeneratesEnergy, }`; exclusions are explicitly `{ }`. |
| `TriggeredChargedMarkPlayer` | `sup_dex.lua:1005` | *(empty)* | Types include `Triggered`, `Triggerable`, and `InbuiltTrigger`; name is absent as a usable base name. |

## Interpretation

- The mechanics ID and source provenance are complete for the loaded records.
- The base name is absent on eight records; these entries should remain
  addressable by ID and must not receive a fabricated display name.
- `skillTypes` is present and parsed for 842 records. Its absence on the other
  records is a source-coverage gap, not a parser error.
- Support requirements and exclusions are complete across the support records
  in this snapshot. Their lower all-record percentages reflect that these
  fields do not apply to non-support records.
- Trigger-related metadata appears on 455 records under the stated combined
  definition. It describes PoB mechanics declarations only and does not create
  relationships between build skills.
- Three duplicate IDs remain an explicit lookup ambiguity. Source locations
  are included above so they can be reviewed against PoB data if needed.
- Counts and the fingerprint describe this installed PoB snapshot; they are
  not guaranteed for another PoB version.
