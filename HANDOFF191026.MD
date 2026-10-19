\# Phase 4D.7C Handoff

\## Weapon Set Data Preservation



\### Status



COMPLETED



Date: 2026-10-19



\---



\# Objective



Preserve all directly observable weapon-set-related data from exported PoB2 XML builds without inferring semantics or introducing optimisation behaviour.



This phase was explicitly focused on:



\- Discovering weapon-set-related XML structures

\- Validating findings against a real build corpus

\- Importing and preserving observable data

\- Avoiding assumptions regarding meaning or relationships



This phase was NOT intended to:



\- Resolve skill-to-weapon-set mappings

\- Determine optimisation behaviour

\- Infer passive application rules

\- Implement weapon-set optimisation



\---



\# Investigation Summary



\## Build Corpus



Weapon Set Discovery Report evolved through multiple scans.



Final corpus:



\- 38 XML builds

\- 37 unique exports

\- Multiple classes

\- Multiple ascendancies

\- Multiple TreeData versions



Version Validation corpus:



\- 38 passive-tree specs

\- 100% successful version resolution

\- 0 resolution failures



\---



\# Validated XML Structures



The following structures were observed repeatedly and are considered authoritative imported data.



\## Passive Allocation Data



Observed locations:



```xml

Tree/Spec/WeaponSet1/@nodes



Tree/Spec/WeaponSet2/@nodes

```



Preserved:



\- Raw node string

\- Parsed node IDs

\- Node count

\- Block presence flag



\---



\## Weapon Slot Data



Observed locations:



```xml

Items/ItemSet/Slot

```



Observed slot names:



```text

Weapon 1



Weapon 2



Weapon 1 Swap



Weapon 2 Swap

```



Preserved:



\- Slot name

\- Item ID

\- Resolved item

\- Populated status



\---



\## Item Set Data



Observed locations:



```xml

Items



ItemSet

```



Preserved:



\- ItemSet IDs

\- ItemSet count

\- All ItemSet records

\- Active ItemSet selector

\- ItemSet attributes



Important:



```text

ItemSet is NOT assumed to represent

a weapon set.

```



Discovery findings included:



\- Builds with 1 ItemSet

\- Builds with 2 ItemSets

\- Builds with 7 ItemSets



An earlier draft described multi-ItemSet exports as progression/loadout
workflows. The discovery evidence does not establish that purpose; multiple
ItemSet records alone must not be interpreted as progression or loadouts.



\---



\## Toggle Data



Observed locations:



```xml

Items/@useSecondWeaponSet



ItemSet/@useSecondWeaponSet

```



Preserved separately.



Observed values:



```text

true



false



nil

```



Values are preserved literally.



No coercion performed.



\---



\## Skill Set Data



Observed locations:



```xml

Skills



SkillSet

```



Preserved:



\- Active skill-set selector

\- Skill-set IDs

\- Skill-set count



Important:



```text

SkillSet is NOT assumed to represent

a weapon set.

```



Discovery revealed SkillSets may represent:



\- Act progression

\- Levelling milestones

\- Endgame stages

\- Alternative build configurations



\---



\## Skill Slot Assignments



Observed location:



```xml

Skills/SkillSet/Skill/@slot

```



Observed values:



```text

Weapon 1



Weapon 2



Weapon 1 Swap



Weapon 2 Swap

```



Preserved:



\- Skill identifier

\- SkillSet identifier

\- Literal slot value



\---



\# Implementation



Created:



```text

weapon\_set\_data\_importer.py

```



Shared by:



```text

BuildImporter



PoB2Importer

```



Purpose:



Single source of truth for weapon-set-related XML ingestion.



Avoids duplicated parser logic.



\---



\# Tests Added



Created:



```text

test\_weapon\_set\_data\_import.py

```



Coverage includes:



\- WeaponSet1/2 allocations

\- Swap slots

\- Multiple ItemSets

\- Skill slots

\- true toggle values

\- false toggle values

\- nil toggle values

\- Builds with no weapon-set structures

\- Importer parity validation



Result:



```text

393 tests passed

```



\---



\# Documentation Added



Created:



```text

WeaponSetData.md

```



Documents:



\- XML source locations

\- Imported fields

\- Stored fields

\- Known limitations

\- Non-goals



\---



\# Evidence-Based Conclusions



\## High Confidence



The following are directly serialized by PoB and are safe to preserve:



```text

WeaponSet1 nodes



WeaponSet2 nodes



ItemSets



activeItemSet



SkillSets



activeSkillSet



Weapon slots



Swap slots



Skill slot assignments



useSecondWeaponSet

```



\---



\# Explicit Non-Conclusions



The investigation DOES NOT establish the following:



```text

Skill -> WeaponSet1



Skill -> WeaponSet2



Weapon 1 Swap -> WeaponSet2



Weapon 2 Swap -> WeaponSet2



useSecondWeaponSet meaning



has\_multiple\_weapon\_sets meaning

```



None of these associations were proven.



No importer logic should infer them.



\---



\# Future Investigation Candidates



Not required for importer functionality.



Potential future work:



\## Skill Slot Correlation Study



Determine whether:



```text

Skill/@slot



correlates with



WeaponSet1

WeaponSet2

```



through controlled exports.



\---



\## Weapon Set Resolution



Future Build Understanding phase may investigate:



```text

Skill

&#x20;   ↓

Slot

&#x20;   ↓

Equipment

&#x20;   ↓

Passive Allocation

```



if evidence supports it.



\---



\## Optimizer Consumption



Future consumers may utilise:



```text

WeaponSet1 allocations



WeaponSet2 allocations



Skill slot assignments



Swap-slot equipment

```



for optimisation logic.



No such behaviour exists today.



\---



\# Final Phase Assessment



Version Resolution

✅ Validated



Weapon Set Discovery

✅ Completed



Weapon Set Preservation

✅ Completed



Weapon Set Import

✅ Completed



Skill-to-WeaponSet Mapping

⏸ Deferred



Weapon Set Semantics

⏸ Deferred



Weapon Set Optimisation

⏸ Deferred



\---



\# Architectural Outcome



Import facts now.



Store facts now.



Interpret later.



Optimise later.



Weapon-set-related evidence is now preserved and available for future subsystems without requiring importer changes.
