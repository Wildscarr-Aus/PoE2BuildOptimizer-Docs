# Contributor Guidance

## Architecture and Scope

- Treat PoB-generated `TreeData`, `Data/Skills`, and gem data as read-only
  authorities. Read, parse, cache, and analyze them; never modify them.
- Follow the documented dependency order: authoritative PoB facts, build
  identity, validated evidence, build understanding, then optimizer behavior.
- Investigate and document before implementing new behavior. Keep changes
  within the active milestone and preserve existing behavior elsewhere.

## Evidence and Conclusions

- Evidence records facts or reproducible derivations with provenance and
  lineage. Evidence is immutable; conclusions are separate, replaceable, and
  must reference their supporting evidence.
- Do not infer a skill role, importance, viability, or damage-source status
  from one proxy such as support count, a skill name, or damage capability.
- Preserve multi-role and unresolved outcomes. Absence of evidence does not
  prove that a skill is useless or unimportant.
- The Draft 2020-12 Evidence Schema validator supports version 2.0.0, but its
  field and vocabulary contract still needs reconciliation with the Phase
  4D.3 design proposal. Do not wire producers to either contract until that
  discrepancy is explicitly resolved.

## Validation

- Inspect the implementation and relevant tests before changing behavior.
- Add focused regression coverage for behavior changes and run the smallest
  relevant test selection; run the full suite when the task requires broader
  confidence.
- Record real-build review findings and distinguish confirmed behavior from
  unresolved hypotheses. Do not introduce skill-name-specific exceptions or
  propagation assumptions.
- Preserve pre-existing worktree changes and repository-specific configuration.

## Weapon-Set Data Boundary

- Phase 4D.7C imports and preserves directly observable weapon-related XML
  facts. Preserve literal values and source distinctions; do not infer
  relationships between ItemSets, SkillSets, skill slots, toggles, or
  `WeaponSet1/2` allocations.
- No Evidence Contract predicate or producer ownership is implied by data
  preservation. Weapon-set semantics, skill-to-WeaponSet mapping, and
  optimizer behavior remain deferred. See `Docs/WeaponSetData.md`.
