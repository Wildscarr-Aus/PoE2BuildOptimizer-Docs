# PoB2 Roaming Data Ingestion Report

**Scan date:** 2026-10-17  
**Scanned root:** `C:\Users\teamp\AppData\Roaming\Path of Building Community (PoE2)`  
**Scan type:** Recursive read-only file inventory, targeted inspection of textual data sources, and comparison with the optimizer's existing loaders.

## Executive summary

The installed PoB2 directory contains **1,703 files totaling 443,214,456 bytes (about 422.7 MiB)**. Most of that size is versioned passive-tree imagery and compressed assets, not build-analysis metadata. The highest-value data sources for this optimizer are:

1. **`Data\gems.lua`** — best first source for intrinsic gem classification and stable gem metadata. It contains `gemType`, tags, a granted-effect identifier, and variant metadata. The existing `GemDatabase` already parses it, but its lookup is name-keyed and `SkillIdentityResolver` does not consume it.
2. **`Data\Skills\act_*.lua`, `sup_*.lua`, `minion.lua`, `spectre.lua`, and `other.lua`** — detailed skill behavior and support compatibility. These provide semantic detail not present in build XML or the basic gem catalog, but are Lua data files with PoB-specific structures and should be parsed deliberately rather than by broad text matching.
3. **`TreeData\<version>\tree.json`** — authoritative, version-specific passive-tree data. This is already the optimizer's primary tree input and should continue to be selected through its version-aware path.
4. **`Data\SkillStatMap.lua` and `Data\StatDescriptions\...`** — useful for later stat interpretation and explanations, but lower priority for determining the role of a socketed gem.

The scan found a particularly useful join key: XML `skill_id` values match `gems.lua` `grantedEffectId` values for inspected gems, even where XML `gem_id` differs from the catalog's `gameId`. The metadata distinguishes intrinsic gem properties such as `trigger`, `support`, `herald`, `curse`, and `companion`; it cannot by itself prove that a particular skill was triggered in a build. Triggered-skill classification still requires relationship/context analysis.

## Inventory and scan scope

The recursive inventory found these file types:

| Extension | Files |
|---|---:|
| `.lua` | 998 |
| `.png` | 366 |
| `.zst` | 176 |
| `.tga` | 112 |
| `.dll` | 26 |
| `.tgf` | 7 |
| `.json` | 6 |
| `.cfg` | 2 |
| `.txt` | 2 |
| `.jpg` | 2 |
| `.md` | 1 |
| `.ini` | 1 |

Major directory totals:

| Directory | Files | Approx. size | Notes |
|---|---:|---:|---|
| `Data` | 874 | 36.68 MiB | Primarily Lua game data; includes skill and stat datasets. |
| `TreeData` | 453 | 351.92 MiB | Five version directories (`0_1` through `0_5`) plus `legion`; large share is compressed graphics. |
| `Classes` | 79 | 1.60 MiB | PoB application/UI/runtime code, not a clean ingestion dataset. |
| `Modules` | 28 | 2.42 MiB | PoB runtime modules; useful as behavioral reference, not initial game-data input. |
| `Assets` | 97 | 2.34 MiB | Application assets. |
| `SimpleGraphic` | 120 | 6.14 MiB | Graphics/runtime assets. |
| `lua` | 11 | 0.31 MiB | Runtime Lua files. |
| `Update` | 0 | 0 | Empty at scan time. |

The `Data` directory has 869 Lua files and five compressed assets. Its highest-value files and subdirectories are detailed below. The `TreeData` directory includes five `tree.json` files corresponding to `0_1`–`0_5`; the repository's version detector currently recognizes versions containing `tree.json` and selects the highest version, so `0_5` is the latest recognized tree at scan time.

### Scan limitations

- The inventory was recursive, but this was not a semantic review of every Lua file.
- Detailed inspection focused on skill/gem metadata, the relevant tree-version layout, and current repository ingestion code.
- Binary assets, compressed graphics, executable files, and `poe_api_response.json` were not opened or ingested.
- No installed PoB2 files were modified.

## Recommended data sources

### Priority 1 — `Data\gems.lua`

**Size:** 533,787 bytes (about 521 KiB).  
**Use:** Canonical first lookup for gem identity, intrinsic role tags, and basic gem categories.

The current repository loader, [`Src/Io/gem_loader.py`](../../Src/Io/gem_loader.py), parses this file and retains:

- `name`
- `gameId`
- `variantId`
- `grantedEffectId`
- `gemType`
- `tags`
- `naturalMaxLevel`

The installed catalog contains 966 parsed entries; the current loader's lowercase-name dictionary contains 961 records after records with absent names are skipped and duplicate normalized names overwrite earlier entries. Tag counts below are over those 961 current name-keyed records, so they are catalog observations rather than guaranteed counts of unique game mechanics.

| Catalog tag/type | Records observed | Classification value |
|---|---:|---|
| `support` tag / `gemType=Support` | 566 | Strong intrinsic support indicator. |
| `trigger` tag | 111 | Strong indicator that the gem can act as a trigger; not evidence that a target was actually triggered. |
| `aura` tag | 15 | Intrinsic aura classification. |
| `herald` tag | 7 | Intrinsic herald classification. |
| `curse` tag | 16 | Intrinsic curse classification. |
| `companion` tag | 11 | Intrinsic companion classification. |
| `grants_active_skill` tag | 445 | Indicates a granted active skill, but not necessarily that it is a damage source. |

These categories can overlap. A role representation should not presume each gem has exactly one mutually exclusive label. `UTILITY` is not represented by one general tag in the inspected catalog; treat it as a deliberate fallback or a separately defined classification, not as an inferred fact from missing tags.

#### Verified ID join examples

The inspected XML's `skill_id` matched the corresponding `grantedEffectId` for each item below. XML `gem_id` did not always match catalog `gameId`.

| Build gem | XML `skill_id` / catalog `grantedEffectId` | Catalog evidence |
|---|---|---|
| Cast on Critical | `MetaCastOnCritPlayer` | `gemType=Buff`; tags include `trigger` and `meta`. |
| Profane Ritual | `ProfaneRitualPlayer` | `gemType=Spell`; tags include `spell` and `grants_active_skill`. |
| Boundless Energy II | `SupportBoundlessEnergyPlayerTwo` | `gemType=Support`; tag `support`. |
| Elemental Weakness | `ElementalWeaknessPlayer` | `gemType=Spell`; tag `curse`. |
| Frost Bomb | `FrostBombPlayer` | `gemType=Spell`; active skill metadata. |
| Flame Wall | `FlameWallPlayer` | `gemType=Spell`; active skill metadata. |
| Herald of Ice | `HeraldOfIcePlayer` | `gemType=Buff`; tag `herald`. |
| Herald of Thunder | `HeraldOfThunderPlayer` | `gemType=Buff`; tag `herald`. |
| Companion: Frozen Mandibles | `SummonBeastPlayer` | Catalog name is templated (`Companion: {0}`); tags include `minion` and `companion`. |

For example, the XML `gem_id` for Cast on Critical ends in `SkillGemCastOnCritical`, while the catalog `gameId` ends in `SkillGemCastOnCriticalStrike`. The matching `skill_id`/`grantedEffectId` is therefore a better primary join candidate in this sample. Keep `variantId` and `gameId` as additional disambiguation/fallback data; do not make display names the sole key.

#### Existing integration gap

`GemDatabase` currently indexes by `name.lower()` and stores catalog identifiers as record values. It does not expose an index by `grantedEffectId`, `gameId`, or `variantId`. [`Src/Analysis/skill_identity.py`](../../Src/Analysis/skill_identity.py) currently copies `gem_id` and `skill_id` into `SkillRecord` but does not consult `GemDatabase`; consequently the available tags are not used to classify roles.

The name-keyed index also means same-name variants can overwrite each other. Retaining multiple records per name and indexing by stable IDs would be safer for skill identity, variants, aliases, and templated companion names.

### Priority 2 — `Data\Skills\`

**Total:** 15 files, about 19.27 MiB, including 10 Lua files and five compressed image assets.

The Lua skill catalog files are:

- `act_dex.lua`
- `act_int.lua`
- `act_str.lua`
- `sup_dex.lua`
- `sup_int.lua`
- `sup_str.lua`
- `minion.lua`
- `spectre.lua`
- `other.lua`
- `SkillAssets.lua`

**Use:** Enrich catalog-level tags with PoB skill behavior, skill types, support requirements/exclusions, granted effects, and mechanic-specific metadata.

Representative verification:

- In `act_int.lua`, `skills["MetaCastOnCritPlayer"]` describes Cast on Critical as gaining Energy on critical hits and triggering socketed Spells at maximum Energy. Its skill types include `Meta` and `Triggers`.
- In `sup_int.lua`, `skills["SupportBoundlessEnergyPlayerTwo"]` has `support = true` and requires `SkillType.GeneratesEnergy`.
- `act_int.lua` contains the inspected Frost Bomb, Flame Wall, and Herald of Ice definitions.

These files provide direct evidence for the behavior of a trigger gem and compatibility constraints that `gems.lua` alone does not provide. The Lua files include PoB-specific tables, symbolic `SkillType` values, and expressions/calls, so they should be treated as structured source requiring a purpose-built parser or narrowly scoped extraction—not parsed with a generic text search or executed as untrusted input.

### Priority 3 — `TreeData\<version>\tree.json`

**Use:** Passive-tree nodes, connections, stats, and other version-specific tree facts. This source is already wired into the optimizer through [`Src/Core/Versioning/version_detector.py`](../../Src/Core/Versioning/version_detector.py) and its tree-loading path.

The installed versions at scan time were `0_1`, `0_2`, `0_3`, `0_4`, and `0_5`. Each recognized version has `tree.json`; `tree.lua` is also present. The overall `TreeData` footprint is about 351.92 MiB, mostly due to tree graphics and compressed assets. For optimizer ingestion, prefer the existing version-selected `tree.json` path and exclude background/icon atlases unless a concrete feature requires them.

### Priority 4 — stat and skill-stat mapping

Useful files for later stat interpretation, effect explanation, or skill-level calculation include:

- `Data\SkillStatMap.lua` (about 108 KiB)
- `Data\StatDescriptions\stat_descriptions.lua` (about 4.15 MiB)
- `Data\StatDescriptions\gem_stat_descriptions.lua` (about 616 KiB)
- `Data\StatDescriptions\active_skill_gem_stat_descriptions.lua` (about 135 KiB)
- `Data\StatDescriptions\meta_gem_stat_descriptions.lua` (about 13 KiB)
- `Data\StatDescriptions\Specific_Skill_Stat_Descriptions\` (per-skill definitions)

These are valuable after the build's gem identity and role are known. They are not the first source to ingest for distinguishing support gems, triggers, curses, or damage contributors.

### Priority 5 — minion/spectre and other auxiliary data

- `Data\Minions.lua` (about 47 KiB)
- `Data\Spectres.lua` (about 745 KiB)
- `Data\Skills\minion.lua`
- `Data\Skills\spectre.lua`

These may enrich minion and companion identity, skill behavior, and entity details. For the inspected Companion: Frozen Mandibles example, `gems.lua` already provides a reliable `companion` tag and the `SummonBeastPlayer` identity; the display name is build/variant-specific while the catalog name is templated. Treat runtime names as instance labels, not catalog keys.

### Lower priority for current V1 build analysis

- `Data\ModItem*.lua`, `Data\ModJewel.lua`, `Data\ModRunes.lua`, and related modifier catalogs could be valuable if equipment, jewels, runes, or item optimization enters scope. The current project plan treats gear as fixed for V1 passive-tree optimization, so these should not precede gem identity or skill relationships.
- `Data\QuestRewards.lua` may support progression/build-planning features, but does not directly resolve current build skill roles.
- `Classes\`, `Modules\`, and root runtime Lua files can be consulted to understand PoB behavior, but are application implementation code rather than stable, clean datasets for direct ingestion.
- PNG/TGA/TGF/ZST graphics, DLLs, EXEs, UI state, and API/cache responses are not recommended as build-analysis data inputs.

## Comparison with current optimizer ingestion

| Pipeline location | Current behavior | Data gap relevant to ingestion |
|---|---|---|
| [`Src/Optimization/build_importer.py`](../../Src/Optimization/build_importer.py) | Imports one SkillSet's gem names and IDs and group-level DPS flag into `BuildModel`. | Does not preserve all group identity/selection fields or classify support/trigger roles. |
| [`Src/Core/build_model.py`](../../Src/Core/build_model.py) | `GemModel` stores name, level, quality, `gem_id`, `skill_id`, and `variant_id`; `SkillGroupModel` stores label, DPS flag, and gems. | Group model lacks stable socket-group ID, `main_active_skill`, and explicit support/role metadata. |
| [`Src/Audit/skill_signature.py`](../../Src/Audit/skill_signature.py) | Extracts active skill set, group index, group flags, gem IDs, enabled flags, variants, and stat-set indices directly from XML. | Provides raw build facts but does not join them to the installed gem/skill catalogs. |
| [`Src/Analysis/skill_identity.py`](../../Src/Analysis/skill_identity.py) | Produces identity records and primary skill selection. | `classification` defaults to `None`; no role lookup or gem database join occurs. Group-level `include_in_full_dps` is copied onto each gem record. |
| [`Src/Analysis/skill_relationships.py`](../../Src/Analysis/skill_relationships.py) | Emits ownership plus `UNKNOWN` same-active-set relationships. | Does not use trigger tags, meta-gem behavior, support compatibility, or the socketed target structure to classify edges. |
| [`Src/Io/gem_loader.py`](../../Src/Io/gem_loader.py) | Parses the installed `gems.lua`; already used by gem validation/export-related paths. | Indexes by lowercase display name and is not integrated into `SkillIdentityResolver`. |
| [`Src/Optimization/build_profile_builder.py`](../../Src/Optimization/build_profile_builder.py) | Builds character/tree profile fields. | Does not populate its skill collections; current skill analysis is separate from the profile. |

## Recommended ingestion plan

1. **Use the installed PoB2 data as a read-only authority.** Resolve its root through configuration, retain source version/path and refresh metadata, and cache parsed data rather than modifying PoB files.
2. **Make `gems.lua` the initial metadata join.** Prefer XML `skill_id` ↔ catalog `grantedEffectId` for the verified cases; retain `gem_id`, `gameId`, and `variantId` to disambiguate and diagnose mismatches. Preserve collisions instead of allowing one same-name gem to overwrite another.
3. **Populate intrinsic, potentially multi-valued gem roles from catalog metadata.** `Support`, `trigger`, `aura`, `herald`, `curse`, and `companion` are evidenced by `gemType` or tags. Do not infer `UTILITY` merely because no specific tag matched.
4. **Keep intrinsic classification separate from build relationships.** A `trigger` tag says the gem can trigger; a `TRIGGERED_SKILL` role belongs to a specific skill identified as a target by relationship/configuration evidence. The trigger gem's detailed skill definition and support/skill requirements can constrain that inference.
5. **Use `Data\Skills\` selectively for mechanics and compatibility.** Resolve relevant definitions by `skill_id`/granted-effect ID, including support `requireSkillTypes` and `excludeSkillTypes`. Preserve “unknown” when the data does not establish a relationship.
6. **Preserve XML group context in the canonical build records.** Active set, group identity/order, selected main active skill, group DPS flag, per-gem enabled state, IDs, variant, and stat-set selections are necessary to join catalog facts to the actual build without treating every gem in a group as equivalent.
7. **Reuse existing version-aware tree ingestion.** Continue selecting `TreeData\<version>\tree.json` through the current version context; avoid copying all version graphics into optimizer caches.
8. **Defer stat-description and item-mod catalogs until there is a consuming feature.** They are large and valuable for calculations, but are not required for the first role-classification increment.

## Bottom line

For the immediate goal of accurate skill identity and role classification, **`Data\gems.lua` is the best first ingestion source, joined primarily by `skill_id`/`grantedEffectId`; `Data\Skills\` is the second-stage source for mechanics and compatibility.** Existing tree ingestion already has the right versioned source in `TreeData\<version>\tree.json`. The biggest integration gap is not availability of installed metadata: it is that the current skill identity and relationship pipeline does not consume the gem catalog, and the build model/profile do not retain all group semantics needed to apply it safely.
