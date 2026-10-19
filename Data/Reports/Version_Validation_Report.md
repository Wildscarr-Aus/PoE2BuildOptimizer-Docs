# Version Validation Report

**Phase:** 4D.7B — Version Validation & Build Corpus Analysis  
**Validation date:** 2026-10-19  
**Build directory:** `C:\Users\teamp\OneDrive\Documents\Path of Building (PoE2)\Builds`  
**Scope:** Discovery and read-only validation; no code changes.

## Executive Summary

All **33** available build XML files were parsed. Every build contains a
`Tree/Spec/@treeVersion`; all 38 `Spec` records across the corpus were passed
through the existing `get_version_context(treeVersion)` function in the
project's Version Resolution subsystem. Every requested context resolved
successfully and its `tree.json` exists.

The corpus contains three **declared passive-tree data versions**:

- `0_5`: 30 builds
- `0_2`: 2 builds
- `0_1`: 1 build

All 33 files have `Build/@targetVersion="0_1"`. The repository's subsystem
does not detect the PoB2 application release that created or last saved a
build. A search of all XML element names and attributes found only
`targetVersion` and `treeVersion` as version-named evidence; neither is an
application-release version. Therefore, the PoB2 application release is
**UNKNOWN for all 33 builds**, and the corpus does **not** establish four
application-version generations.

The existing module successfully resolves a supplied tree version to
installed tree resources, but it is not an XML build-version detector.
Reported tree-version matches are HIGH confidence for that narrow resolution
task because the module result equals the XML declaration and the
corresponding installed `tree.json` exists. This is not independent proof of
the PoB2 application release or of the build's save history.

The XML contains observed structure variation across the declared tree
versions, including `WeaponSet1/2` blocks in the sampled `0_5` builds and
skill-related fields in the sampled `0_2` files. The sample is small and
uneven across versions; these are version-correlated observations, not proof
that a tree version caused a format change.

All files are structurally readable and have the core build, tree, item,
skill, config, and import sections. Their active item/skill selections
resolve, and every build has non-empty passive allocation data. No obvious
structural incompleteness was observed. Migration status remains UNKNOWN:
the `targetVersion`/`treeVersion` difference does not prove migration.

## Version Distribution

### Declared and Resolved TreeData Versions

| `Tree/Spec/@treeVersion` | Builds | Specs | Existing `VersionContext` result | `tree.json` available |
|---|---:|---:|---|---|
| `0_1` | 1 | 2 | `0_1` for both specs | 2 / 2 |
| `0_2` | 2 | 3 | `0_2` for all specs | 3 / 3 |
| `0_3` | 0 | 0 | Installed version exists; not represented in corpus | — |
| `0_4` | 0 | 0 | Installed version exists; not represented in corpus | — |
| `0_5` | 30 | 33 | `0_5` for all specs | 33 / 33 |
| **Total** | **33** | **38** | **38 successful resolutions** | **38 / 38** |

The subsystem reported available installed versions
`0_1`, `0_2`, `0_3`, `0_4`, and `0_5`. Thus the corpus covers three of the
five available TreeData versions; `0_3` and `0_4` have no build samples.

### Other Corpus Statistics

#### Build `targetVersion`

| Value | Builds |
|---|---:|
| `0_1` | 33 |

#### Class

| Class | Builds |
|---|---:|
| Druid | 8 |
| Mercenary | 8 |
| Ranger | 5 |
| Monk | 4 |
| Witch | 4 |
| Huntress | 2 |
| Sorceress | 2 |

#### Ascendancy

| Ascendancy | Builds |
|---|---:|
| Gemling Legionnaire | 8 |
| Shaman | 7 |
| Martial Artist | 4 |
| Deadeye | 4 |
| Infernalist | 2 |
| Lich | 2 |
| Amazon | 1 |
| Spirit Walker | 1 |
| Oracle | 1 |
| Pathfinder | 1 |
| Stormweaver | 2 |

#### Migration / Integrity Assessment

| Assessment | Builds |
|---|---:|
| Migration status UNKNOWN | 33 |
| No obvious structural incompleteness observed | 33 |
| Structurally incomplete based on checks below | 0 |

## Version Detection Results

### Existing Subsystem Used

The validation used the existing functions in
`Src/Core/Versioning/version_detector.py`:

- `get_available_versions()` to enumerate installed TreeData versions.
- `get_version_context(version)` once for each declared
  `Spec/@treeVersion` (38 calls total).
- Each returned context was checked for the existence of its `tree.json`.

The module's `VersionContext.version` matched the corresponding XML
`treeVersion` for all 38 specs. No unsupported version or missing tree
resource was encountered.

`get_version_context()` is a resource resolver, not a build-file detector:
it accepts an optional version argument, and when omitted it defaults to
the latest available version. To validate a build's tree resources, the
declared `treeVersion` must be supplied. The subsystem does not read
`Build/@targetVersion`, parse the build XML, infer a PoB2 application
version, or identify whether the build was migrated.

### Outcome Counts

| Result class | TreeData version resolution | PoB2 application release |
|---|---:|---:|
| Correct / supported resolution | 33 builds, 38 specs | Not measurable |
| Questionable | 0 | 0 distinguishable app versions |
| Failed | 0 | Not applicable; no app-version detector |
| Unknown | 0 tree-version resolutions | 33 builds |

### Per-Build Results

`Version source` is `Tree/Spec/@treeVersion` passed to the existing
`get_version_context()` resolver. `PoB2 app release` is UNKNOWN because
none is serialized in the inspected XML. Allocation counts are
comma-separated node IDs from `Spec/@nodes`, one count per spec. `WS1/WS2`
means presence and node count of the corresponding child allocation block.
`useSecondWeaponSet` lists the literal value(s) from `Items` and its
`ItemSet`; the values match in every file. All builds have this attribute.

| Build filename | App release | target / treeVersion | Subsystem result / confidence | Class / ascendancy | Specs; allocated nodes per spec | Passive allocations | WS1 | WS2 | `useSecondWeaponSet` | Incomplete? | Migration |
|---|---|---|---|---|---|---|---|---|---|---|---|
| `aanewtest/Spin to Win Monk 0.5.5.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Monk / Martial Artist | 1; 144 | Yes | Yes / 16 | Yes / 15 | `false` | No obvious issue | UNKNOWN |
| `Amazon/farcuetwo.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Huntress / Spirit Walker | 1; 119 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Amazon/Whirling twisters.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Huntress / Amazon | 1; 153 | Yes | Yes / 24 | Yes / 24 | `true` | No obvious issue | UNKNOWN |
| `Druid/Druid pets.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 123 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Druid/elemental weakness.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Oracle | 1; 133 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Druid/End Game Fissure Bear.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 126 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Druid/Firestorm Druid.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 117 | Yes | No / 0 | No / 0 | `nil` | No obvious issue | UNKNOWN |
| `Druid/Leveling build.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 112 | Yes | No / 0 | No / 0 | `nil` | No obvious issue | UNKNOWN |
| `Druid/Shaman Calamity.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 131 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Druid/Totem Arc Druid.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 133 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Druid/wildfirestorm.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Druid / Shaman | 1; 121 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/Arc totem.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 129 | Yes | No / 0 | No / 0 | `nil` | No obvious issue | UNKNOWN |
| `Marauder/Ashfurtitan.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 97 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/FR Arc Totems.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 122 | Yes | No / 0 | No / 0 | `nil` | No obvious issue | UNKNOWN |
| `Marauder/gemling firesmasher live.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 94 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/gemling firesmasher.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 132 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/scarrarctot.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 129 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/Totem Arc Gemling.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 128 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/wildfireballer.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Mercenary / Gemling Legionnaire | 1; 114 | Yes | Yes / 5 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Marauder/wildspinning.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Monk / Martial Artist | 1; 144 | Yes | Yes / 16 | Yes / 15 | `false` | No obvious issue | UNKNOWN |
| `Monk/Spin to Win Monk 0.5.5.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Monk / Martial Artist | 1; 144 | Yes | Yes / 16 | Yes / 15 | `false` | No obvious issue | UNKNOWN |
| `Monk/Spin to Win Monk.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Monk / Martial Artist | 1; 149 | Yes | Yes / 19 | Yes / 19 | `false` | No obvious issue | UNKNOWN |
| `Ranger/Gastro Eruptus outofdate.xml` | UNKNOWN | `0_1 / 0_1` | `0_1` / HIGH | Ranger / Pathfinder | 2; 94, 140 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Ranger/Lightning Endgame.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Ranger / Deadeye | 1; 116 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Ranger/new shockdeadeye.xml` | UNKNOWN | `0_1 / 0_2` | `0_2` / HIGH | Ranger / Deadeye | 1; 19 | Yes | No / 0 | No / 0 | `nil` | No obvious issue | UNKNOWN |
| `Ranger/shocking_hood pre0.5.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Ranger / Deadeye | 1; 126 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Ranger/Shocking_hood.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Ranger / Deadeye | 2; 126, 126 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Sorc/Lightning Spark.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Sorceress / Stormweaver | 3; 120, 18, 108 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Sorc/wildsparksorc.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Sorceress / Stormweaver | 1; 140 | Yes | Yes / 22 | Yes / 22 | `false` | No obvious issue | UNKNOWN |
| `Witch/chaoticwild pre0.5.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Witch / Infernalist | 1; 122 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Witch/cold witch.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Witch / Infernalist | 1; 117 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Witch/Live shockitch outofdate.xml` | UNKNOWN | `0_1 / 0_2` | `0_2` / HIGH | Witch / Lich | 2; 38, 133 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |
| `Witch/Spark Witch.xml` | UNKNOWN | `0_1 / 0_5` | `0_5` / HIGH | Witch / Lich | 1; 113 | Yes | No / 0 | No / 0 | `false` | No obvious issue | UNKNOWN |

## Build Integrity Assessment

### ORIGINAL / MIGRATED / UNKNOWN

| Classification | Count | Basis |
|---|---:|---|
| ORIGINAL | 0 | No source export timestamp, originating PoB application release, or known-original control files were available to prove originating-version authorship. |
| MIGRATED | 0 | No migration marker or known before/after copy was available. |
| UNKNOWN | 33 | The available XML evidence does not distinguish an original export from a later open/save. |

Every build has `targetVersion="0_1"`. Thirty-two builds have a different
`treeVersion` (`0_2` or `0_5`). The difference is real XML evidence but does
not establish migration: these fields describe different version
observations, and `targetVersion` is not an embedded PoB application
version. Filenames containing words such as `pre0.5` or `outofdate` are not
treated as proof of export history.

### Incomplete / Structural Integrity

All 33 parsed XML documents have `Build`, `Tree/Spec`, `Items`, `Skills`,
`Config`, and `Import` sections. Every build has non-empty `Spec/@nodes`
passive allocation data. All active item-set and active skill-set selectors
resolve to exactly one corresponding set, and all inspected nonzero item
slot references resolve to item records. Some builds have multiple tree
specs; their per-spec node counts are included above, and no active-version
resolution failure occurs in those specs.

Result: **no obvious structural incompleteness observed (33/33)**. This is
not a judgment that every gameplay choice, calculation, or optional field
is complete.

## Cross-Version XML Comparison

### Common Outer Structure

All three declared tree-version groups contain the same ten top-level
elements: `Build`, `Tree`, `Skills`, `Config`, `TreeView`, `Items`, `Import`,
`Calcs`, `Notes`, and `Party`. The presence of these common outer elements
does not mean their nested content or attributes are identical.

### Observed Nested Differences

| Structure or attribute | `0_1` sample (1 build) | `0_2` sample (2 builds) | `0_5` sample (30 builds) |
|---|---|---|---|
| `Tree/Spec/WeaponSet1` | 0 builds | 0 builds | 7 builds |
| `Tree/Spec/WeaponSet2` | 0 builds | 0 builds | 6 builds |
| `ExportedBuffs` element | 0 builds | 1 build | 0 builds |
| `Skill/@source` | 0 builds | 1 build | 27 builds |
| `Skill/@slot` | 0 builds | 1 build | 25 builds |
| `Skill/@groupCount` | 0 builds | 1 build | 1 build |
| `Gem/@skillMinion` | 0 builds | 1 build | 21 builds |
| `Gem/@skillMinionCalcs` | 0 builds | 1 build | 4 builds |
| `Gem/@skillMinionSkill` | 0 builds | 1 build | 19 builds |
| `Gem/@skillMinionSkillCalcs` | 0 builds | 1 build | 19 builds |
| `SkillSet/@title` | 0 builds | 0 builds | 1 build |
| `BeastCompanion` element | 0 builds | 0 builds | 9 builds |
| `MinionStat` element | 0 builds | 0 builds | 3 builds |
| `Spectre` element | 0 builds | 0 builds | 2 builds |
| `TradeSearchWeights` element | 1 build | 1 build | 26 builds |

The sample shows **observed differences**, not version guarantees. For
example, `WeaponSet1/2` occur only among the 30 `0_5`-tagged builds, but
only 7 and 6 builds respectively contain them. Differences may reflect
build content, optional data, or save history as well as version. The
corpus does not isolate those factors.

The same `targetVersion="0_1"` and the same outer sections occur across all
three tree-version groups. `useSecondWeaponSet` is present in all builds and
has the same value on `Items` and `ItemSet`; its observed values are
`false` (27), `nil` (5), and `true` (1). The `activeItemSet` value is `1`
throughout; `activeSkillSet` is `1` in 32 builds and `2` in one. These
fields do not themselves identify application version.

## Detection Failures

### Failed TreeData Resolutions

**None.** All 38 spec-level version references resolve using the existing
module, and each resolved `tree.json` exists.

### Missing Application-Version Detection

The module does not provide PoB2 application-release detection from build
XML. No version-named application-release element or attribute was found in
the corpus. Consequently:

- The tree version can be resolved from XML and installed data.
- The PoB2 application release that authored or last saved the file cannot
  be determined from the inspected evidence.
- The four suspected application-version generations cannot be confirmed
  or ruled out by the current module.

This is a **capability gap relative to the app-version question**, not a
failure to resolve the declared TreeData version.

## Confidence Assessment

| Claim | Confidence | Reason |
|---|---|---|
| The 33 builds declare tree versions `0_1`, `0_2`, or `0_5` in the reported counts | HIGH | Direct XML attributes across every scanned build. |
| The current module resolves each declared tree version to installed resources | HIGH | All 38 specs were passed through `get_version_context()`; all results matched and all `tree.json` paths exist. |
| `targetVersion` distribution is `0_1` for all builds | HIGH | Direct `Build/@targetVersion` observation. |
| The corpus contains four PoB2 application-version generations | UNKNOWN | No application release identifier was found; tree versions and filenames are insufficient evidence. |
| Observed nested XML differences are associated with the sampled tree-version groups | HIGH | The presence/absence and counts are directly observed in this corpus. |
| Those XML differences are caused by TreeData version | MEDIUM | Version groups differ, but sample size is uneven and build content/save history is uncontrolled. |
| A particular build is original or migrated | UNKNOWN | No known provenance or migration marker is available. |
| Any build is structurally incomplete under the report's checks | HIGH confidence that none were observed | Required checked sections, nonempty allocation, active selection references, and item references passed for all files. |

### Version Resolution Strengths and Gaps

**Strengths**

- Enumerates installed TreeData versions from registered `TreeData`
  directories.
- Sorts multi-part version strings numerically.
- Creates a `VersionContext` with version-specific tree resource paths.
- Rejects missing version directories or missing `tree.json`.
- Resolved every declared tree version in this corpus, including the two
  older represented values.

**Gaps**

- Does not read build XML or extract `Spec/@treeVersion` itself.
- Does not identify PoB2 application releases or export generations.
- Does not determine original versus migrated save status.
- A no-argument context request selects the latest installed version; callers
  must explicitly supply a build's tree version when resolving a build.
- Does not report which installed resource version was selected based on a
  build file unless the caller supplies and retains that association.

## Additional Sample Recommendations

The next samples should establish provenance rather than merely add more
unlabeled XML:

| Priority | Additional sample | Needed count | Expected value |
|---|---|---:|---|
| 1 | Known-original PoB2 exports saved by a recorded application release, with the release captured independently at export time | 2 per suspected app-version era | Establish an external ground truth for app version and reveal any embedded marker or structural signature. |
| 2 | Known-migrated builds with preserved before/after XML and recorded source and destination PoB2 releases | 2 paired migrations per suspected era transition | Distinguish migration changes from ordinary build-content differences. |
| 3 | Builds using installed TreeData versions `0_3` and `0_4` | At least 2 distinct builds per version | Add missing corpus coverage for supported TreeData resources and compare their XML fields. |
| 4 | Known-original and known-migrated builds with multiple passive specs, weapon-set allocations, and varied skill/item configurations | At least 2 of each status | Test whether the observed nested structures track version, content, or migration. |

**Current confidence:** HIGH for declared TreeData version resolution;
UNKNOWN for application-release detection and build migration.

**Expected confidence after sampling:** TreeData coverage becomes
representative only after `0_3` and `0_4` are sampled. App-version
confidence could rise to MEDIUM after paired, independently labeled
original/migrated examples reveal a repeatable XML signature. HIGH requires
100% agreement across known-ground-truth samples and no contradictory
examples; the required sample counts above are a minimum investigation
target, not a guarantee of that outcome.

## Final Recommendation

Record `Spec/@treeVersion` as the build's declared TreeData version and
resolve it by explicitly passing it to the existing versioning subsystem.
Do not label this value as the PoB2 application release. Keep application
version and migration status UNKNOWN until independently version-labeled
original exports and paired migrated exports are available.

The existing module passes the declared TreeData resolution check for all
33 builds. No code change is recommended by this validation-only task.
