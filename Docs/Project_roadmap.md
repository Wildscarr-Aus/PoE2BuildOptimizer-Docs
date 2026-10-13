============================================================
POE2 BUILD OPTIMIZER ROADMAP
============================================================

Vision
------------------------------------------------------------

Create a standalone Path of Exile 2 Build Optimizer capable of:

• Importing PoB2 builds
• Understanding build identity
• Scoring passive trees
• Finding improved passive allocations
• Exporting optimized builds
• Presenting meaningful optimization choices

End Goal:

Build
    ↓
Analyze
    ↓
Optimize
    ↓
Export
    ↓
Play


============================================================
VERSION 1.0 ROADMAP
============================================================

Goal
------------------------------------------------------------

Produce a reliable passive tree optimizer focused on
single-objective optimization.

Primary Objective:

DPS Optimization


============================================================
PHASE 1 - TREE AUDITOR
============================================================

Status:
✅ COMPLETE

Completed:

✅ Tree JSON loading
✅ Node classification
✅ Special access node discovery
✅ Conditional pathable discovery
✅ Unlock constraint discovery
✅ Audit generation
✅ Version-aware audit storage

Outputs:

Data/Audits/<version>/


============================================================
PHASE 2 - GRAPH BUILDER
============================================================

Status:
✅ COMPLETE

Completed:

✅ Graph generation
✅ Normal node connections
✅ Conditional path handling
✅ Ascendancy handling
✅ Special access nodes
✅ Validation testing


============================================================
PHASE 3 - PATHFINDER
============================================================

Status:
✅ COMPLETE

Completed:

✅ Tree traversal
✅ Path generation
✅ Connected tree validation
✅ Multi-class support
✅ Ascendancy support
✅ Testing


============================================================
PHASE 4A - BUILD FOUNDATION
============================================================

Status:
✅ COMPLETE

Completed:

✅ BuildModel
✅ BuildImporter
✅ BuildExporter
✅ Round Trip Validation

Validated:

Build File
    ↓
BuildModel
    ↓
Build File

Preserves:

✅ Character
✅ Ascendancy
✅ Level
✅ Tree Version
✅ Allocated Nodes
✅ Weapon Set Data


============================================================
PHASE 4B - BUILD UNDERSTANDING
============================================================

Status:
🚧 IN PROGRESS


------------------------------------------------------------
4B-1 Build Profiles
------------------------------------------------------------

Status:
✅ COMPLETE

Completed:

✅ BuildProfile
✅ BuildProfileBuilder
✅ Profile Validation

Currently Extracted:

✅ Character Class
✅ Ascendancy
✅ Level
✅ Allocated Nodes
✅ Available Passive Points


------------------------------------------------------------
4B-2 Skill Importing
------------------------------------------------------------

Status:
✅ COMPLETE

Completed:

✅ SkillGroupModel import
✅ GemModel import
✅ Gem names
✅ Gem levels
✅ Gem IDs
✅ Skill IDs
✅ Variant IDs

Validation:

✅ Skill groups imported
✅ Gems imported
✅ Gem names imported
✅ Gem levels imported
✅ Gem IDs imported

------------------------------------------------------------
4B-3 Skill Metadata & Damage Chain Investigation
------------------------------------------------------------

Status:

🚧 ACTIVE

Goals:

Investigate how PoB2 represents:

activeSkillSet

mainSocketGroup

mainActiveSkill

mainActiveSkillCalcs

StatSetIndex

grantedEffect

FullDPSSkill

WeaponSet1

WeaponSet2

Version Metadata

Determine:

✅ Active Skill Group
✅ Active Skill
✅ Active Subskill
✅ DPS Skill
✅ Trigger Skills
✅ Meta Skill Relationships
✅ Damage Source
✅ Damage Enabler
✅ Damage Amplifiers
✅ Primary Damage Chain
✅ Weapon Set Relationships

Deliverables:

skill_signature.py

skill_chain_report.py

Investigation Outputs

Data/Investigations/SkillSignature/<version>/

Data/Investigations/SkillChain/<version>/

Validation:

Totem Builds

Meta Builds

Triggered Builds

Weapon Set Builds

Multi-Skill Builds

------------------------------------------------------------
4B-4 Damage Chain Detection
------------------------------------------------------------

Status:

⏳ PLANNED

Goals:

Identify:

• Damage Source

• Damage Enabler

• Damage Amplifiers

• Primary Damage Chain

Populate:

BuildProfile.damage_chain

BuildProfile.primary_damage_source

BuildProfile.primary_damage_enablers

Validation:

Totem Builds

Meta Skill Builds

Triggered Builds

Weapon Set Builds

Subskill Builds

Multi-Skill Builds



------------------------------------------------------------
4B-5 Skill Classification
------------------------------------------------------------

Status:
⏳ PLANNED

Classify Skills:

Active Skill

Support Skill

Meta Skill

Passive Skill

Triggered Skill

Ascendancy Skill

Granted Skill

Aura

Herald

Minion


------------------------------------------------------------
4B-6 Build Archetype Detection
------------------------------------------------------------

Status:
⏳ PLANNED

Identify:

Build Style

Weapon Type

Damage Type

Defence Type

Examples:

Cold Crit Quarterstaff Monk

Fire Slam Gemling

Lightning Arc Totem Gemling


============================================================
PHASE 5 - PASSIVE SCORING
============================================================

Status:
⏳ PLANNED

Goals:

Score passive nodes relative to build goals.

Develop:

Passive Value System

Travel Cost Evaluation

Node Synergy Evaluation

Build Alignment Scoring

Damage Chain Evaluation

Weapon Set Awareness

Passive scoring must evaluate
impact on the complete damage chain
rather than a single skill.


============================================================
PHASE 6 - OPTIMIZER ENGINE
============================================================

Status:
⏳ PLANNED

Goals:

Generate candidate passive trees.

Compare to existing tree.

Respect user constraints.

Preserve build identity.

Preserve weapon-set structure.

Select best candidate.

Examples:

Optimize within 20 points

Optimize within 50 points

Full Passive Respec

Output:

OptimizationResult


============================================================
PHASE 7 - USER INTERFACE
============================================================

Status:
⏳ PLANNED

Goals:

✅ Build Import
✅ Build Analysis
✅ Optimization Options
✅ Result Review
✅ Build Export


============================================================
PHASE 8 - INSTALLER & DEPLOYMENT
============================================================

Status:
⏳ PLANNED

Goals:

✅ PoB2 detection
✅ TreeData detection
✅ Folder creation
✅ Configuration generation
✅ Installer
✅ Uninstaller

Architecture:

Installer handles setup.

Optimizer focuses only on optimization.


============================================================
VERSION 1.0 RELEASE CRITERIA
============================================================

Required:

✅ Build Import
✅ Build Analysis
✅ Damage Chain Detection
✅ Weapon Set Validation
✅ Version-Aware Build Analysis
✅ Passive Scoring
✅ Optimization Engine
✅ Export
✅ UI
✅ Installer

Release:

PoE2 Build Optimizer v1.0


============================================================
VERSION 2.0 ROADMAP
============================================================

Goal
------------------------------------------------------------

Move from

"Best DPS Build"

to

"Best Tradeoff Options"


------------------------------------------------------------
Multi-Objective Optimization
------------------------------------------------------------

Optimization Types:

DPS

Defence

Mana Sustain

Spirit Efficiency

Balanced


------------------------------------------------------------
Candidate Explorer
------------------------------------------------------------

Return:

Maximum DPS Build

Defensive Build

Balanced Build

Sustain Build

Alternative Builds


------------------------------------------------------------
Tradeoff Analysis
------------------------------------------------------------

Display:

DPS Gain/Loss

Defence Gain/Loss

Sustain Gain/Loss

Spirit Gain/Loss


------------------------------------------------------------
User Goal Selection
------------------------------------------------------------

Optimize For:

DPS

Defence

Mana Sustain

Balanced

Custom

------------------------------------------------------------

Build Advisor

------------------------------------------------------------

Recommend:

Equipment Upgrades

Jewel Upgrades

Support Upgrades

Build Improvements

while preserving current build identity.

Provide:

Upgrade Priority Lists

Stat Priority Recommendations

Build Improvement Suggestions

============================================================
FUTURE ROADMAP
============================================================

Build Constraints

Node Locking

Cluster Preservation

Maximum Respec Budget


------------------------------------------------------------

Advanced Analysis

Secondary Skill Detection

Defence Profiling

Multi-Skill Optimization

Weapon Set Optimization

------------------------------------------------------------

Build Timeline Planner

------------------------------------------------------------

Generate:

Level 1
    ↓
Endgame

Progression Plans

Determine:

Best Leveling Skills

Transition Points

Passive Milestones

Gear Milestones

Endgame Activation Timing

Support:

League Starters

Midgame Builds

Endgame Builds

------------------------------------------------------------

Optional AI Build Guide

------------------------------------------------------------

AI remains optional.

Optimizer remains source of truth.

AI provides:

Build Explanations

Leveling Guides

Timeline Generation

Transition Planning

League Starter Guidance

AI Requirements:

User Authorisation Required

No Developer-Funded AI

Support Local and User-Provided AI

Optimizer Remains Fully Functional
Without AI

------------------------------------------------------------

Community Features

Build Libraries

Build Sharing

Build Comparisons

Reference Build Database


------------------------------------------------------------

Skill Metadata Investigation
------------------------------------------------------------

Investigate:

    act_dex.lua
    act_int.lua
    act_str.lua

    sup_dex.lua
    sup_int.lua
    sup_str.lua

    minion.lua
    spectre.lua
    other.lua

Goals:

    - Skill Tags
    - Support Tags
    - Compatibility Rules
    - Attribute Requirements
    - Spirit Costs
    - Granted Effects
    - Mechanic Metadata


============================================================
ARCHITECTURE REQUIREMENTS
============================================================

REQ-SKILL-001
------------------------------------------------------------

Before optimization begins:

User should confirm the active skill selection
inside PoB2 when required.

Reason:

PoB2 may occasionally contain an incorrect
primary skill selection.


------------------------------------------------------------

REQ-SKILL-002

Validate primary skill detection against:

• Missing selections
• Incorrect selections
• Subskill builds
• Meta builds
• Trigger builds
• Totem builds
• Minion builds


------------------------------------------------------------

REQ-SKILL-003

Document and understand:

activeSkillSet

mainSocketGroup

mainActiveSkill

mainActiveSkillCalcs

StatSetIndex

grantedEffect

FullDPSSkill


------------------------------------------------------------

REQ-OPT-001

The optimizer must be capable of determining:

"No DPS improvement exists."


------------------------------------------------------------

REQ-OPT-002

If no DPS improvements exist,
alternative optimization directions may
still be offered.

Examples:

More Defence

Better Sustain

Lower Cost

Higher Spirit Efficiency


============================================================
VALIDATION LIBRARY
============================================================

REQ-VALIDATION-001
------------------------------------------------------------

Maintain validation builds for:

Poor Trees

Average Trees

Good Trees

Highly Optimized Trees

Reference Optimal Trees


------------------------------------------------------------

REQ-VALIDATION-002

Maintain skill edge-case builds:

Subskill Builds

Meta Skill Builds

Triggered Skill Builds

Totem Builds

Minion Builds

Multi-Skill Builds

Incorrectly Configured Builds

Missing Main Skill Builds


============================================================
CURRENT NEXT MILESTONE
============================================================

Phase 4B-3

Skill Metadata & Damage Chain Investigation

Status:

🚧 ACTIVE

Goal:

Determine exactly how PoB2 identifies:

• Active Skill Group
• Active Skill
• Active Subskill
• DPS Skill
• Damage Source
• Damage Enabler
• Meta Skill Relationships
• Trigger Relationships
• Weapon Set Relationships

and build a trusted Damage Chain
Detection system before implementing
optimisation logic.