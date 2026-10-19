# Phase 4D.7C Weapon-Set Data Preservation Handoff

**Status:** COMPLETE  
**Date:** 2026-10-19

## Purpose

Preserve weapon-set-related facts directly serialized in PoB2 build XML.
This work does not decide weapon-set semantics or introduce optimizer
behavior.

## What Was Investigated and Proven

- The refreshed Weapon Set Discovery corpus contains 38 XML files with 37
  distinct contents; all 38 parsed successfully.
- That discovery snapshot contains 50 `Tree/Spec` elements.
- XML directly stores `WeaponSet1/2` allocation blocks, item-set slot
  records and item references, root and per-item-set
  `useSecondWeaponSet` strings, active item/skill selectors, skill-set
  records, and literal `Skill/@slot` values.
- The separate Phase 4D.7B version-validation snapshot covered 38
  passive-tree specs. All 38 declared tree versions resolved through the
  existing TreeData resource resolver; zero resolutions failed.
- This validates resolution of installed TreeData resources only. It does
  not determine the original PoB application version or a build's migration
  history.

Multiple `ItemSet` records and swap-slot fields are observed structures.
The scan did not establish what each set means or how skill slots correspond
to passive allocation blocks.

## What Was Implemented

The shared reader `Src/Io/weapon_set_data_importer.py` is used by
`BuildImporter` and `PoB2Importer`. The imported model preserves:

- Per-spec `WeaponSet1/2` block presence, raw node strings, node tokens,
  and counts.
- All ItemSet records, IDs, attributes, all slots, item IDs, resolved item
  references, and populated status.
- The `Items` attributes and root `useSecondWeaponSet`, separately from
  each ItemSet's literal toggle string.
- The active item-set ID and selected ItemSet record.
- All SkillSet records and IDs, active skill-set ID, and set count.
- Literal skill slot assignments and their containing skill-set IDs, plus
  directly serialized gem identifiers.

## What Was Intentionally Deferred

- Weapon Set Semantics.
- Skill → WeaponSet Mapping.
- Weapon Set Optimisation Logic.

No semantic mappings were approved:

- ItemSet != Weapon Set.
- SkillSet != Weapon Set.
- Skill Slot != `WeaponSet1`/`WeaponSet2`.

No optimizer behavior or Evidence Contract predicate emission was added.
Import Facts Now; Store Facts Now; Interpret Later; Optimise Later.

## Validation

- Focused importer, round-trip, and preservation tests: **31 passed**.
- Full `Tests` suite: **393 passed**.
- Pylance diagnostics for changed Python files: **none**.
- `git diff --check`: **passed**.

## Documentation and Authority

- `Data/Reports/Weapon_Set_Discovery_Report.md`
- `Data/Reports/Version_Validation_Report.md`
- `Docs/WeaponSetData.md`
- `Docs/Project_roadmap.md`
- `Docs/Architecture.md`
- `Docs/System_architecture_register.md`
- `Docs/project_knowledge_base.md`
- `Docs/Investigation_Archive.md`
- `Data/Reports/Evidence_Schema_Validation.md`

The earlier `HANDOFF191026.MD` in the documentation repository is retained
as an existing session record. This canonical handoff supersedes any
unsupported interpretation of why multi-ItemSet records occur.

## Recommended Next Roadmap Target

Resume the approved evidence-first Phase 4 work in the order recorded in
`Docs/Project_roadmap.md`. The Phase 4D.7 Wave 1 alignment report remains
PARTIAL/BLOCKED by the deferred `weapon_set_association_observed`
predicate. Any future work on that predicate requires an approved source
rule; do not infer a skill-to-WeaponSet mapping to unblock it.
