# Phase 4D.7 Wave 1 Alignment Report

**Status:** PARTIAL — evidence emitted, validated, and accepted; full Wave 1
alignment remains blocked by the explicitly deferred predicate.

## Executive Summary

Wave 1 evidence was generated for the four approved real-build fixtures:
Whirling Twisters, Gemling Firesmasher, Spin to Win Monk, and the additional
End Game Fissure Bear build selected by the documented build-selection
process.

The three Wave 1 producers emitted 3,222 Evidence Contract 3.0.0 records
across 11 predicates. All records passed schema, vocabulary, semantic,
ownership, and collection-lineage validation and were accepted by the
append-only Evidence Ledger. No producer evidence failures or unresolved
build-level emission issues occurred.

`weapon_set_association_observed` remains explicitly deferred. It was not
inferred or emitted. The records that were in scope all validate, but the
unresolved predicate prevents claiming complete Wave 1 alignment.

## Producer Counts

| Producer | Evidence records |
|---|---:|
| BuildImporter | 1,068 |
| PoBSkillDatabase | 1,627 |
| CapabilityNormaliser | 527 |
| **Total** | **3,222** |

## Predicate Counts

| Predicate | Evidence records |
|---|---:|
| `mechanics_field_declared` | 518 |
| `mechanics_expression_preserved` | 409 |
| `mechanics_lookup_resolved` | 173 |
| `skill_type_declared` | 527 |
| `capability_declared` | 527 |
| `support_count_observed` | 55 |
| `support_instance_configured` | 140 |
| `investment_fact_observed` | 692 |
| `primary_skill_selected` | 4 |
| `skill_enabled` | 173 |
| `active_skill_set_selected` | 4 |
| **Emitted predicates** | **11** |
| `weapon_set_association_observed` | **Deferred; 0 emitted** |

The approved Wave 1 matrix assigns 12 predicates to these producers. Eleven
were emitted; the remaining predicate is excluded by the user's deferral.

## Evidence Counts per Build

| Build | Source locator | BuildImporter | PoBSkillDatabase | CapabilityNormaliser | Total | Ledger accepted |
|---|---|---:|---:|---:|---:|---:|
| Whirling Twisters | `Amazon/Whirling twisters.xml` | 276 | 459 | 174 | 909 | 909 |
| Gemling Firesmasher | `Marauder/gemling firesmasher.xml` | 210 | 307 | 89 | 606 | 606 |
| Spin to Win Monk 0.5.5 | `Monk/Spin to Win Monk 0.5.5.xml` | 346 | 528 | 183 | 1,057 | 1,057 |
| End Game Fissure Bear | `Druid/End Game Fissure Bear.xml` | 236 | 333 | 81 | 650 | 650 |
| **Total** |  | **1,068** | **1,627** | **527** | **3,222** | **3,222** |

The additional Fissure Bear build is the previously selected random
validation build documented in
`Contributor_Discovery_Validation_Report.md`.

## Validation Results

- **Evidence Contract 3.0.0 schema:** PASS — all 3,222 emitted records passed
  record validation.
- **Vocabulary and predicate validation:** PASS — every category and
  predicate matches Vocabulary Registry 1.0.0.
- **Semantic and collection validation:** PASS — identity, subject, scope,
  provenance, payload, state/strength, evidence-path, and lineage checks
  passed for the collection.
- **Ownership validation:** PASS — every record's producer, predicate,
  category, and source system match the approved producer matrix.
- **Build identity and mechanics lookup:** PASS — 173 configured gem
  instances resolved to unique PoB mechanics records and emitted lookup
  evidence.
- **Support evidence:** PASS — 55 observed support counts agree with the
  directly configured support-instance records; 140 support instances were
  recorded.
- **Capability normalization:** PASS — all 527 capability records copy their
  corresponding declared PoB skill-type token verbatim and retain
  `derived_from` lineage.
- **Deferred predicate:** PASS — no weapon-set association was inferred or
  emitted.
- **Failures:** None. All four builds completed with zero emission issues.

## Ledger Results

- Records submitted: **3,222**
- Records accepted: **3,222**
- Record-count mismatch: **No**
- Duplicate evidence IDs or invalid lineage: **None**
- Ledger acceptance: **PASS**

The ledger was populated using its batch append API after full collection
validation. Existing BuildImporter output was compared before and after
evidence emission for the first selected build and remained unchanged.

## Risks

1. **Weapon-set association is incomplete by authorization.** The matrix
   assigns `weapon_set_association_observed` to BuildImporter, but the user
   deferred this predicate. Do not infer it from indirect flags such as
   `useSecondWeaponSet`.
2. Two XML `count` attributes contain the literal text `nil`. Each is
   preserved as an observed string with an explicit limitation; neither is
   converted to zero or treated as a numeric count.
3. Capability normalization is intentionally an identity mapping of declared
   PoB skill-type tokens. It does not infer broader game capabilities.
4. This work does not align relationship, contributor, outcome, role,
   importance, viability, or optimizer producers.

## Discovery Gate Result

**PASS** — the approved Evidence Contract 3.0.0, Vocabulary Registry 1.0.0,
Predicate Registry 1.0.0, and Producer Ownership Registry were used. The
additional build matches the documented prior selection process. No
unresolved discovery issue prevented emission for the authorized predicates.

## Alignment Gate Result

**PARTIAL / BLOCKED** — all emitted records and all authorized producer
paths passed validation and ledger acceptance. Full Wave 1 alignment cannot
pass while `weapon_set_association_observed` remains deferred and unimplemented.

## Recommendation

Accept the 11-predicate implementation as validated Wave 1 partial alignment.
Keep the overall Wave 1 gate open. Resume only after the deferred
weapon-set source rule is approved; then implement and validate that
predicate separately. Do not expand this work to later producer waves.
