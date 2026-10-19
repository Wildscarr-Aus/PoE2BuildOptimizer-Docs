#=====================================================================
#
# PROJECT_KNOWLEDGE_BASE.md
#
# PoE2 Build Optimizer
#
# Authoritative Project Memory
#
#=====================================================================



#=====================================================================
#
# DOCUMENT METADATA
#
#=====================================================================

Project

    PoE2 Build Optimizer

Document Purpose

    Authoritative project memory.

Status

    Active

Companion Documents

    SYSTEM_ARCHITECTURE_REGISTER.md

    INVESTIGATION_ARCHIVE.md

    PROJECT_ROADMAP.md



#=====================================================================
#
# DOCUMENT RELATIONSHIPS
#
#=====================================================================

PROJECT_KNOWLEDGE_BASE.md

Purpose

    Project Brain

Contains

    Decisions

    Discoveries

    Current Status

    Critical Locations

    Recovery Information

------------------------------------------------------------

SYSTEM_ARCHITECTURE_REGISTER.md

Purpose

    Project Map

Contains

    Directories

    Files

    Responsibilities

    Dependencies

    Protected Assets

------------------------------------------------------------

INVESTIGATION_ARCHIVE.md

Purpose

    Research Archive

Contains

    Investigation Details

    Methods

    Findings

    Historical Evidence

------------------------------------------------------------

PROJECT_ROADMAP.md

Purpose

    Execution Plan

Contains

    Phases

    Milestones

    Acceptance Criteria

    Future Work

------------------------------------------------------------

Update Rule

    Knowledge Base

        Why decisions were made.

    Architecture Register

        Where decisions exist.

    Investigation Archive

        How discoveries were proven.

    Roadmap

        What happens next.



#=====================================================================
#
# SESSION RECOVERY REQUIREMENTS
#
#=====================================================================

For full project recovery provide:

    PROJECT_KNOWLEDGE_BASE.md

    SYSTEM_ARCHITECTURE_REGISTER.md

    INVESTIGATION_ARCHIVE.md

    PROJECT_ROADMAP.md

Together these are considered the
minimum authoritative project package.



#=====================================================================
#
# CURRENT PROJECT STATUS
#
#=====================================================================

Repository Audit

    Complete

Current Development Status

    Foundation systems identified.

    Protected architecture assets identified.

    Audit phase completed.

Quality Control Philosophy

    Validation is a dedicated project phase.

    Deployment may not begin until
    QA acceptance criteria have been met.

    Every major subsystem requires:

        Development

            ↓

        Validation

            ↓

        Phase Acceptance    

Current Focus

    Phase 4D.4 Evidence Schema validation
    is implemented for Draft 2020-12 and
    evidence_version 2.0.0. Before other
    systems emit Evidence Records, resolve
    the implementation/design contract
    discrepancy. Phase 4D.3 Skill Role &
    Viability is design-complete.



#=====================================================================
#
# ROADMAP POSITION
#
#=====================================================================

Current Roadmap

    Phase 1
    Tree Auditor
    Complete

    Phase 2
    GraphBuilder
    Complete

    Phase 3
    Pathfinder
    Complete

    Phase 4
    Build Understanding
    Current work: Evidence Schema contract
    reconciliation, then evidence-backed
    capability and role assessment.

    Phase 5
    UI

   Phase 6
   QA & Quality Control

   Phase 7
   Installer & Deployment

For full roadmap details see:

    PROJECT_ROADMAP.md



#=====================================================================
#
# CRITICAL ARCHITECTURAL DECISIONS
#
#=====================================================================

Decision

    Tree Audit is a first-class subsystem.

Reason

    Audit findings directly influence
    GraphBuilder, Pathfinder, and
    Optimizer requirements.

------------------------------------------------------------

Decision

    Version-aware architecture.

Reason

    Multiple TreeData versions must
    be supported.

------------------------------------------------------------

Decision

    Installer owns setup.

Optimizer owns optimization.

Reason

    Separation of installation and
    runtime responsibilities.

------------------------------------------------------------

Decision

    Rule resolution occurs before
    graph traversal.

Reason

    Additional starts, granted nodes,
    and disconnected allocations
    alter graph behavior.

------------------------------------------------------------

Decision

    GraphBuilder operates on
    node instances.

Optimizer evaluates
    passive definitions.

Reason

    Passive definitions and passive
    instances are separate concepts.



#=====================================================================
#
# PROTECTED DISCOVERIES
#
#=====================================================================

Discovery

    Passive Definition

    !=

    Passive Instance

Impact

    Definition layer required.

------------------------------------------------------------

Discovery

    unlockConstraint

    !=

    Travel Connection

Impact

    Separate traversal and dependency
    systems required.

------------------------------------------------------------

Discovery

    Special Access Nodes exist.

Impact

    GraphBuilder must eventually
    represent them.

------------------------------------------------------------

Discovery

    Conditional Nodes exist.

Impact

    Pathfinder must eventually
    become rule-aware.

------------------------------------------------------------

Discovery

    Tree Auditor findings directly
    influence optimization design.

Impact

    Audit subsystem retained as a
    permanent project component.

For details see:

    INVESTIGATION_ARCHIVE.md



#=====================================================================
#
# PROTECTED ARCHITECTURE ASSETS
#
#=====================================================================

The following systems are foundational
to future development.

Detailed file locations are maintained in:

    SYSTEM_ARCHITECTURE_REGISTER.md

Assets

    VersionContext

    PassiveLookup

    ClassStartLookup

    JewelRuleParser

    TreeRuleManager

    ResolvedTreeRules

    PassiveTreeGraph

    GraphBuilder

    Pathfinder

    PoB2Importer

    TreeAuditor



#=====================================================================
#
# IMPORTANT PROJECT LOCATIONS
#
#=====================================================================

PoB2 Builds Directory

    C:\Users\teamp\OneDrive\Documents\
    Path of Building (PoE2)\Builds

------------------------------------------------------------

PoB2 Application Data

    C:\Users\teamp\AppData\Roaming\
    Path of Building Community (PoE2)

------------------------------------------------------------

TreeData Root

    C:\Users\teamp\AppData\Roaming\
    Path of Building Community (PoE2)\
    TreeData

------------------------------------------------------------

Audit Output Root

    Data/Audits/<version>/

------------------------------------------------------------

Investigation Output Root

    Data/Investigations/



#=====================================================================
#
# CURRENT GRAPHBUILDER REQUIREMENTS
#
#=====================================================================

GraphBuilder must support:

    Travel Connections

    Node Connectivity

    Special Access Nodes

    Conditional Nodes

    Unlock Relationships

    Version-Aware Trees

GraphBuilder must not assume:

    unlockConstraint
    =
    travel path

Phase 2B – GraphBuilder V2

Status:
    In Progress

Step 1A – Registry Containers
    COMPLETE

Added:
    special_access_nodes
    conditional_nodes
    unlock_constraints

Step 1B – Registry Population
    COMPLETE

Verified Counts:

    special_access_nodes = 22

    conditional_nodes = 200

    unlock_constraints = 200

Validation Method:
    GraphBuilder registry population compared
    against TreeAuditor audit output.

Key Finding:
    special_access_nodes are NOT identified by a
    tree.json field.

    TreeAuditor defines special_access_nodes as:

        all_nodes - graph_nodes

    GraphBuilder V2 now uses the same rule.

Step 1C – Audit Validation Tests
    Pending


#=====================================================================
#
# CURRENT PATHFINDER REQUIREMENTS
#
#=====================================================================

Pathfinder must eventually support:

    Additional Starts

    Granted Nodes

    Disconnected Allocations

    Conditional Nodes

    Special Access Nodes

    Unlock Constraints

    Travel Cost Modeling



#=====================================================================
#
# CURRENT OPTIMIZER REQUIREMENTS
#
#=====================================================================

Optimizer must eventually understand:

    Passive Definitions

    Travel Cost

    Unlock Constraints

    Granted Nodes

    Additional Starts

    Conditional Nodes

    Special Access Nodes

    Rule-Aware Traversal

The Optimizer Engine remains the
highest-risk future subsystem.



#=====================================================================
#
# CURRENT RISKS
#
#=====================================================================

Low Risk

    Tree Auditor

    GraphBuilder Foundation

    Pathfinder Foundation

------------------------------------------------------------

Medium Risk

    Export Migration
        to VersionContext

------------------------------------------------------------

High Risk

    Optimizer Engine Rewrite

Reason

    Must integrate all major project
    discoveries into coherent scoring
    and traversal logic.



#=====================================================================
#
# NEXT DEVELOPMENT TARGET
#
#=====================================================================

Immediate Goal

    Complete GraphBuilder architecture
    extension.

Objectives

    Model unlock relationships.

    Model conditional pathing.

    Preserve audit findings.

Success Condition

    GraphBuilder fully represents
    all discovered node relationships
    identified during Tree Auditor work.



#=====================================================================
#
# DOCUMENT MAINTENANCE RULES
#
#=====================================================================

Update Knowledge Base When

    Major decisions change.

    Roadmap position changes.

    New critical discoveries occur.

    Recovery information changes.

------------------------------------------------------------

Do Not Store Here

    File inventories.

    Dependency chains.

    Detailed investigations.

    Historical audit data.

------------------------------------------------------------

Those belong in:

    SYSTEM_ARCHITECTURE_REGISTER.md

    INVESTIGATION_ARCHIVE.md

    PROJECT_ROADMAP.md



#=====================================================================
#
# CHANGE LOG
#
#=====================================================================

Version 2.0

    Architecture Register introduced.

    Investigation Archive introduced.

    Roadmap document introduced.

    Knowledge Base reduced to
    project-memory responsibilities.

    Repository audit completed.

============================================================
V1 SCOPE FREEZE
============================================================

Effective Date:
October 2026

Purpose
------------------------------------------------------------

Protect Version 1.0 from scope creep and
ensure release of a working product.

Rule
------------------------------------------------------------

New functionality must NOT be added to V1
unless one of the following conditions is met:

1. The feature is required for core operation.

OR

2. The absence of the feature prevents
   correct optimisation behaviour.

OR

3. The absence of the feature would
   produce incorrect optimisation results.

Otherwise:

The feature is automatically classified
as V2+ and recorded in the roadmap.

Decision Process
------------------------------------------------------------

Question:

"Does V1 fail without this feature?"

YES
    → Add to V1 roadmap

NO
    → Move to V2 backlog

Examples
------------------------------------------------------------

V1 Features

✅ Skill Metadata Investigation
✅ Primary Skill Detection
✅ Skill Classification
✅ Passive Scoring
✅ Optimizer Engine
✅ UI
✅ Installer

V2 Features

✅ Multi-Objective Optimization
✅ Defensive Optimization
✅ Sustain Optimization
✅ Candidate Explorer
✅ Build Comparison
✅ Node Locking
✅ Tree Constraints
✅ Alternative Build Suggestions

V3+ Features

✅ Community Features
✅ Build Sharing
✅ Online Databases
✅ Cloud Synchronisation

Development Rule
------------------------------------------------------------

When a new idea is discovered:

1. Record the idea.

2. Determine if V1 requires it.

3. If not required:
       Move to V2 roadmap.

4. Resume current milestone immediately.

Historical Active Milestone Snapshot
------------------------------------------------------------

Phase 4B-3

Skill Metadata Investigation

No new V1 features are to be introduced
during this phase unless they are required
to correctly identify and optimise builds.

Goal
------------------------------------------------------------

Ship Version 1.0.

A released V1 with future plans is preferred
over an unreleased V1 with endless features.

============================================================

V3+ Vision (Knowledge Base Notes)

Goal:

Transform the optimiser from:

"Optimise my build"

into

"Guide me from Level 1 to Endgame."

Key Features:

- Build Timeline Planner
- Leveling Roadmaps
- League Starter Planning
- Build Transition Planning
- Endgame Progression Guidance

Timeline Concept:

Level 1
    ↓
Leveling Build
    ↓
Transition Build
    ↓
Endgame Build
    ↓
Fully Optimised Build

The system should determine:

- Best leveling skills
- Best transition points
- Required passive milestones
- Required gear milestones
- Required attribute milestones

AI Vision:

AI is optional.

Optimizer remains the source of truth.

AI acts as:

- Advisor
- Teacher
- Planner
- Explanation Layer

AI never performs optimisation directly.

AI uses optimiser results to generate:

- Explanations
- Guides
- Timelines
- Recommendations

AI Requirements:

- User authorisation required
- No developer-funded AI
- Support local or user-provided AI
- Optimizer must remain fully functional without AI

Possible AI Sources:

- System AI
- Local AI
- User-installed AI
- Future supported providers

Long-Term Principle:

V1
= Optimise the build the player has

V2
= Improve the build the player has

V3+
= Help guide the player to the build they want


#=====================================================================
#
## Authoritative Evidence-First Status — 2026-10-18

This status supersedes the older phase snapshots above. The implementation
provides a Draft 2020-12 Evidence Schema validator for version 2.0.0, but its
required fields and vocabularies differ from portions of the Phase 4D.3
design proposal. No producer should adopt the contract until that mismatch
is resolved and the selected contract is validated.

The intended sequence is: approve the shared evidence contract; emit
validated capability and build-context facts; derive multi-role skill,
importance, and viability conclusions with evidence references; then revisit
damage-source integration and optimizer consumers. Evidence is immutable;
conclusions are replaceable and must remain traceable.

Real-build review found structurally valid Cast on Critical trigger chains
for Profane Ritual, Elemental Weakness, Frost Bomb, and Flame Wall in
Whirling Twisters. Boundless Energy II's paths to triggered targets remain
indirect and unresolved. Herald skills emitted as secondary-damage chains
despite mechanics evidence not declaring Damage or DamageOverTime remain
suspicious and require future evidence-backed classification. These findings
do not authorize name-based fixes or propagation assumptions.

## Authoritative Phase 4D.7C Status — 2026-10-19

Weapon Set Discovery (4D.7A), Version Validation (4D.7B), and Weapon-Set
Data Preservation (4D.7C) are complete. The preservation implementation
imports directly observed XML facts without assigning weapon-set semantics.

The importer preserves:

- `WeaponSet1/2` allocation block presence, raw node strings, node tokens,
  and counts.
- All ItemSet records, IDs, slot references, selected ItemSet ID, and
  root/per-ItemSet `useSecondWeaponSet` values separately.
- All SkillSet records, IDs, active selector, and literal skill-slot
  assignments.

No semantic mappings are approved. ItemSet != Weapon Set; SkillSet !=
Weapon Set; Skill Slot != WeaponSet1/WeaponSet2. Weapon Set Semantics,
Skill → WeaponSet Mapping, and Weapon Set Optimisation remain deferred.
Project rule: **Import Facts Now; Store Facts Now; Interpret Later;
Optimise Later.**

The Phase 4D.7B version-validation snapshot resolved all 38 passive-tree
specs (100%, zero failures) through the existing TreeData resource
resolver. That resolver does not determine original PoB application
version or build migration history. See the Phase 4D.7C handoff and
`Data/Reports/Version_Validation_Report.md`.

# END OF KNOWLEDGE BASE
#
#=====================================================================