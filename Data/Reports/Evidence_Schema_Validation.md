# Evidence Schema Validation

**Validation date:** 2026-10-18

**Implementation:** `Src/Core/Evidence/`

**Schema package:** `jsonschema 4.26.0`

## Schema Status

| Check | Result |
|---|---|
| Draft version | 2020-12 |
| Schema loaded | PASS |
| Schema meta-validation | PASS (`Draft202012Validator.check_schema`) |
| Supported `evidence_version` | `2.0.0` |
| Unknown schema versions | Rejected with a visible validation error |
| Full regression suite | PASS (368 tests) |
| Pylance diagnostics for new Python files | None |
| `git diff --check` | PASS |

## Contract Enforced

The JSON Schema requires `evidence_version`, `evidence_id`, `build_id`, `skill_id`, `skill_name`, `category`, `type`, `source_system`, and `strength`. It validates optional socket group, value, evidence path, lineage, timestamp, and notes when present; socket group accepts null, required skill identifiers do not, and values are restricted to JSON-compatible types.

Allowed evidence strengths:

- `Observed`
- `Derived`
- `Inferred`

Allowed evidence categories:

- `Capability`
- `Relationship`
- `Contributor`
- `Mechanic`
- `Investment`
- `BuildContext`
- `DamageChain`

Evidence paths require well-formed source-system/locator steps. Lineage requires valid reference shapes; `Derived` and `Inferred` records require ancestry. Collection validation resolves all lineage IDs, rejects duplicate IDs and missing parents, and detects cycles. `EvidenceLedger` provides an append-only in-memory acceptance boundary: duplicate IDs are rejected, stored inputs are detached copies, and batch writes are atomic.

Evidence version `2.0.0` is the only registered implementation version. Supporting a future incompatible version requires adding a distinct schema and explicit compatibility tests; unknown versions fail closed.

## Test Results

Focused evidence tests: **35 passed**.

| Fixture group | Valid cases | Rejected cases |
|---|---:|---:|
| Schema enum, required-field, nullable, and optional-field cases | 12 | 14 |
| Validator valid examples (capability, relationship, contributor, Herald, resource) and valid ancestry collection | 7 | — |
| Direct malformed-record cases (missing field, invalid enums/version/path/timestamp/lineage, missing derived ancestry) | — | 8 |
| Collection and append-only cases (duplicate ID, missing parent, cycle, non-object, duplicate append, atomic batch failure) | — | 6 |

| Metric | Count |
|---|---:|
| Valid records tested | 19 schema/API positive fixture cases |
| Invalid records tested | 22 direct schema/API negative fixture cases |
| Expected failures | 14 validator/collection rejection assertions |
| Unexpected failures | 0 |

Full suite: **368 passed**.

## Validation Semantics

- `validate_evidence_record(record)` validates one record's versioned JSON shape, enums, types, timestamps, path steps, and lineage structure. It raises `EvidenceValidationError` with actionable messages on invalid input.
- `validate_evidence_collection(records)` additionally checks unique evidence IDs, resolves lineage references within the submitted collection, and verifies acyclic ancestry.
- `load_evidence_schema(version)` returns a defensive copy of the selected schema after Draft 2020-12 meta-validation.
- Append-only behavior is enforced by `EvidenceLedger`; schema validation alone cannot detect whether an external persistence system overwrote a previously accepted record.
- Collection ancestry is validated against the full collection supplied to the call. Callers must include referenced ancestors or validate using an `EvidenceLedger` that already contains them.

## Contract Scope Note

This implementation follows the Evidence Schema Validator task's explicit strength/category vocabularies and required-field list. Those enums and the smaller required-field set differ from parts of the earlier Phase 4D.3 design proposal. The design document was not modified per task scope. Before other systems emit evidence, the project should resolve that vocabulary/field-set discrepancy and then keep the validator schema version and design contract synchronized.

No relationship, contributor-discovery/classification, damage-chain, resolver, role-design, or optimizer behavior was changed.

## Subsequent Importer Preservation Boundary — 2026-10-19

Phase 4D.7C added preservation of directly serialized weapon-set-related
build XML data to the build model. Imported facts include passive
`WeaponSet1/2` allocation blocks, all `ItemSet` and `SkillSet` records,
active item/skill set selectors, root and per-item-set
`useSecondWeaponSet` strings, named weapon-slot references, and literal
skill-slot assignments.

This is build-data import, not Evidence Contract emission or producer
alignment. No Evidence Records are created from these fields, no predicate
ownership was changed, and no semantic mapping was approved. In particular,
`ItemSet`, `SkillSet`, and skill slot values are not mapped to numbered
weapon-set allocations. See
[`Docs/WeaponSetData.md`](../../Docs/WeaponSetData.md) and the
Phase 4D.7C handoff for the full preservation boundary.
