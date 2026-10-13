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
