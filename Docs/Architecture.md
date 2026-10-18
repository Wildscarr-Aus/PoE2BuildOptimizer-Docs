# Architecture

## Authoritative Data Sources

GGG-generated files are read-only.

This policy applies whether the files are accessed from a local
PoB2 installation or are present in the public repository or
workspace.

Examples:

- `TreeData/*`
- `Data/Skills/*`

These files must never be modified.

The optimiser may:

- Read
- Parse
- Cache
- Analyse

The optimiser must never:

- Modify
- Patch
- Overwrite

## Static Knowledge Layer

- Passive Tree
- Skills
- Supports
- Mechanics
- Conditions

## Dynamic Character Layer

- Items
- Jewels
- Charms
- Flasks
- Runes
- Corruptions

## Build Understanding Architecture

### Layer 1: PoB Knowledge

- `TreeData`
- `gems.lua`
- `Data/Skills`
- `GameVersions`

PoB is authoritative for game data, gem identity metadata, skill mechanics,
compatibility rules, and version information. The optimiser accesses these
sources through the registry and does not modify PoB-generated files.

### Layer 2: Build Identity

- Build XML
- Skill identity
- Resolved PoB metadata

This layer identifies the contents and configuration of an imported build
using build data and authoritative PoB metadata.

### Layer 3: Build Understanding

- Skill relationships
- Damage chains
- Contributors

This layer derives evidence-based meaning from the build and its PoB-backed
identity.

### Layer 4: Optimiser Intelligence

- Optimisation
- Recommendations

This layer uses build understanding to evaluate changes and present useful
recommendations.

> **Key principle:** PoB knows the game. The optimiser understands the build.

## Evidence-First Build Understanding (Current Direction)

Build understanding separates immutable observations from replaceable
conclusions. PoB/build facts, validated relationships, contributor paths,
and mechanics facts are evidence; roles, importance, viability, and damage
classification are derived conclusions that must retain evidence references.

The intended flow is:

`PoB knowledge -> build identity -> mechanics and build evidence -> relationships and contributors -> damage chains -> roles, importance, and viability -> optimisation`

The Evidence Schema validator is implemented for Draft 2020-12 and
`evidence_version` 2.0.0. It is not yet integrated with every evidence
producer. The validator's field and vocabulary contract currently differs
from the Phase 4D.3 design proposal; reconciling that contract is a gate
before other systems emit Evidence Records. Skill role and viability remain
design targets, not optimizer behavior.

For the data inventory and mechanics design evidence, see
`Data/Reports/PoB2_Roaming_Data_Ingestion_Report.md` and
`Data/Reports/Phase_4A_PoB_Skill_Mechanics_Database_Design.md`. Current
validation and role-design details are in
`Data/Reports/Damage_Chain_Validation_Report.md`,
`Data/Reports/Phase_4D_3_Skill_Role_And_Viability_Design.md`, and
`Data/Reports/Evidence_Schema_Validation.md`.
