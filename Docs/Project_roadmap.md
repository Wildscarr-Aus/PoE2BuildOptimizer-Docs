============================================================
POE2 BUILD OPTIMIZER ROADMAP
============================================================

## Authoritative Current Status — 2026-10-19

This status supersedes older "current focus" notes retained in the historical
roadmap below.

- The Phase 4A PoBSkillDatabase implementation and coverage work are present.
- Phase 4D.3 Skill Role & Viability is design-complete.
- Phase 4D.6 Evidence Contract 3.0.0 implementation and validation are
  complete. The Draft 2020-12 schema, Vocabulary Registry 1.0.0, semantic
  validator, explicit version routing, compatibility validation for 2.0.0,
  and v3-only in-memory ledger passed the active suite (383 tests).
- Forty-one fixture collections cover all approved predicate/strength/state
  combinations and all reachable states. No producer or consumer alignment
  was performed; adoption remains subject to separate authorization.
- The 2.0.0 contract remains compatibility-validation only. Contract behavior
  may not be expanded locally; the Alignment Review Stop Rule remains active.
- Damage-chain manual review found structurally valid trigger chains in
  Whirling Twisters, with Boundless Energy II paths to triggered targets
  remaining indirect/unresolved. Herald skills were suspiciously emitted as
  secondary-damage candidates despite the reviewed mechanics evidence; this
  requires evidence-backed classification, not a name-based exception.
- Phase 4D.7A Weapon Set Discovery, Phase 4D.7B Version Validation, and
  Phase 4D.7C Weapon-Set Data Preservation are **COMPLETE**. The current
  discovery inventory covers 38 XML builds (37 distinct contents); all 38
  parsed successfully. The version validation snapshot resolved all 38
  passive-tree specs with zero failures.
- The importer preserves directly observed weapon-set-related XML facts for
  future consumers. **Weapon Set Semantics, Skill → WeaponSet Mapping, and
  Weapon Set Optimisation are DEFERRED.** No semantic mapping is approved.
  The rule is: **Import Facts Now; Store Facts Now; Interpret Later;
  Optimise Later.** See `Docs/WeaponSetData.md` and the Phase 4D.7C closeout.
- Phase 4D.7C validation: 393 tests passed; Pylance was clean for changed
  Python files; `git diff --check` passed.

### Active Phase Order

1. **Complete:** Reconcile, approve, implement, and validate Evidence Contract
   3.0.0; keep evidence immutable and conclusions separately derived.
2. Add validated capability and build-context evidence without assigning
   unsupported roles.
3. Build multi-role skill assessment and importance/readiness outputs that
   explain each conclusion through evidence references.
4. Revalidate damage-source and damage-chain classification against the real
   build fixtures, preserving unresolved cases explicitly.
5. Integrate validated build understanding into optimizer work only after the
   evidence and analysis stages pass acceptance.

Relationship discovery, contributor analysis, damage chains, skill roles,
importance, viability, and optimization must share this evidence-first
sequence. Historical phase notes below remain useful context but do not
override this current ordering.

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

✅ COMPLETE

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
4B-4A Damage Chain Model Separation
------------------------------------------------------------

Status:

✅ COMPLETE

Completed:

✅ Extracted DamageChainRecord from damage_chain_resolver.py
✅ Created canonical DamageChainRecord model in damage_chain_record.py
✅ Updated DamageChainResolver to import and use the canonical model
✅ Added damage_sources collection to DamageChainRecord
✅ Updated related tests and validated the refactor
✅ Resolver, report, and record tests passing (25 tests)

Architectural Outcome:

Damage model and resolution logic are separated.

Ownership:

damage_chain_record.py
    DamageChainRecord

damage_chain_resolver.py
    DamageChainResolver
    resolve_damage_chain()

This establishes the canonical damage-chain model
for future BuildProfile integration.


------------------------------------------------------------
4B-4B Damage Source Promotion and Classification
------------------------------------------------------------

Status:

🚧 PARTIALLY COMPLETE

Current Objective:

Identify and promote damage contributors through
relationship analysis.

Classify and preserve:

• Damage Sources
• Triggers
• Enablers
• Amplifiers
• Supports

## Revised Rule 001

Triggered Skill Promotion

Status:

IMPLEMENTED AND VALIDATED

Definition:

When skill or mechanic A TRIGGERS B:

• Promote B to a damage-source candidate.
• Keep existing damage-source candidates.
• Preserve the trigger relationship and enablers.

Validation Status:

PASSING

Validated By:

- Triggered meta-skill promotion test.
- Multi-source promotion test.
- Twister + triggered skill validation.

Detection must be relationship-driven, using
RelationshipType values such as TRIGGERS, ENABLES,
AMPLIFIES, and SUPPORTS. Do not classify by skill name.

Current focus is contributor identification and
relationship preservation, not contributor ranking.
Rotation analysis is future optimization-phase work.

Validation:

Twister Builds
Cast on Critical Builds
Lightning Arrow / Comet Builds
Totem Builds
Weapon-Set Builds
Multi-Skill Builds

Completed:

• Triggered Skill Promotion implemented.
• Existing damage sources remain preserved.
• Triggered skills are promoted into damage_sources.
• Multi-source damage chains supported.
• Twister validation passing.
• Cast on Crit validation passing.
• Totem/enabler validation passing.
• 13 DamageChainResolver tests passing.

Remaining:

• Formal relationship classification layer.
• Trigger classification.
• Amplifier classification.
• Separation of Triggers vs Enablers.

## Current Test State

Completed:

- DamageChainRecord extraction.
- Canonical model validation.
- Resolver validation.
- Report validation.
- Triggered Skill Promotion validation.

DamageChainResolver Results:

13 Tests Passing

Validated Scenarios:

- Empty identity.
- Primary skill selection.
- Active subskill handling.
- Weapon set preservation.
- Triggered meta-skill promotion.
- Totem enabled damage source resolution.
- Multi-source DPS builds.
- Triggered skill promotion alongside existing contributors.
- Weapon set mismatch handling.
- Twister + trigger interaction.
- Unknown relationship handling.
- Collection initialization.
- Duplicate skill name resolution.

Current Result:

Rule 001 is working as expected.

Triggered skills are promoted into damage_sources while preserving existing contributors.

## Prior Relationship Classification Scope

This earlier task framing is superseded as the immediate next milestone by
Phase 4A below. Its classification goals remain relevant to Phase 4B, which
must not begin until PoBSkillDatabase is implemented.

Phase 4B - Relationship Discovery 2.0

Relationship Classification

Objective:

Introduce first-class classification of relationship roles.

Current State:

Triggers are currently tracked through:

- triggered_skills
- enablers

Target State:

DamageChainRecord should explicitly model:

- damage_sources
- triggers
- enablers
- amplifiers
- supports

Goals:

1. Separate Trigger classification from Enabler classification.
2. Preserve Rule 001 promotion behaviour.
3. Maintain relationship-driven detection.
4. Avoid skill-name specific logic.
5. Validate classification using:
   - Cast on Critical
   - Cast on Shock
   - Cast on Freeze
   - Lightning Rod
   - Totem builds

Expected Outcome:

The optimizer understands not only which skills contribute damage, but also the role each skill performs within the build ecosystem.


============================================================
BUILD KNOWLEDGE & UNDERSTANDING MILESTONES
============================================================

These milestones define the architecture direction following the PoB data
inventory, registry migration, GemDatabase V2, and SkillIdentity metadata
integration. They supersede earlier assumptions that relationship discovery
can proceed directly from gem metadata alone.

------------------------------------------------------------
PHASE 4A - POBSKILLDATABASE
------------------------------------------------------------

Status:
    IMPLEMENTED AND VALIDATED

Purpose:

    Expose PoB skill mechanics as structured data.

Authoritative Source:

    Data/Skills/*.lua

Planned Features:

    Skill Types

    Support Requirements

    Support Exclusions

    Trigger Compatibility

    Mechanics Metadata

Planned Outputs:

    PoBSkillDatabase

    Mechanics Records

    Mechanics Lookups

Implementation and coverage details are recorded in
`Data/Reports/PoBSkillDatabase_Coverage_Report.md`.

------------------------------------------------------------
PHASE 4B - RELATIONSHIP DISCOVERY 2.0
------------------------------------------------------------

Status:
    PENDING

Purpose:

    Produce evidence-based build relationships.

Examples:

    TRIGGERS

    SUPPORTS

    ENABLES

    APPLIES_CURSE

    USES_COMPANION

Principle:

    Relationships require evidence. Unknown relationships remain unknown
    until the available evidence meets the required confidence threshold.

Dependency:

    PoBSkillDatabase must exist before Relationship Discovery 2.0 begins.

------------------------------------------------------------
PHASE 4C - DAMAGE SOURCE RESOLUTION 2.0
------------------------------------------------------------

Status:
    PENDING

Purpose:

    Replace representative-based damage-source selection with resolution
    grounded in the complete build and its evidence-backed relationships.

Dependencies:

    PoBSkillDatabase

    Relationship Discovery 2.0

------------------------------------------------------------
ARCHITECTURE REFERENCES
------------------------------------------------------------

The PoB data inventory and PoBSkillDatabase design evidence are documented in:

    Data/Reports/PoB2_Roaming_Data_Ingestion_Report.md

    Data/Reports/Phase_4A_PoB_Skill_Mechanics_Database_Design.md


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
PREVIOUS MILESTONE COMPLETION RECORD
============================================================

The current architecture sequence is defined in the Build Knowledge &
Understanding Milestones section above. Phase 4A PoBSkillDatabase is
design-complete; its implementation is the next milestone.

Phase 4B-4B

Damage Source Promotion and Classification

Status:

🚧 PARTIALLY COMPLETE

Goal:

Identify and promote damage contributors through
relationship analysis while preserving:

• Existing damage-source candidates
• Trigger relationships
• Enablers, amplifiers, and supports
• Weapon-set relationships

Completed:

• Triggered Skill Promotion implemented.
• Existing damage sources remain preserved.
• Triggered skills are promoted into damage_sources.
• Multi-source damage chains supported.
• Twister validation passing.
• Cast on Crit validation passing.
• Totem/enabler validation passing.
• 13 DamageChainResolver tests passing.

Remaining:

• Formal relationship classification layer.
• Trigger classification.
• Amplifier classification.
• Separation of Triggers vs Enablers.

## Current Test State

Completed:

- DamageChainRecord extraction.
- Canonical model validation.
- Resolver validation.
- Report validation.
- Triggered Skill Promotion validation.

DamageChainResolver Results:

13 Tests Passing

Validated Scenarios:

- Empty identity.
- Primary skill selection.
- Active subskill handling.
- Weapon set preservation.
- Triggered meta-skill promotion.
- Totem enabled damage source resolution.
- Multi-source DPS builds.
- Triggered skill promotion alongside existing contributors.
- Weapon set mismatch handling.
- Twister + trigger interaction.
- Unknown relationship handling.
- Collection initialization.
- Duplicate skill name resolution.

Current Result:

Rule 001 is working as expected.

Triggered skills are promoted into damage_sources while preserving existing contributors.

## Prior Relationship Classification Scope

This earlier task framing is superseded as the immediate next milestone by
Phase 4A above. Its classification goals remain relevant to Phase 4B, which
must not begin until PoBSkillDatabase is implemented.

Phase 4B - Relationship Discovery 2.0

Relationship Classification

Objective:

Introduce first-class classification of relationship roles.

Current State:

Triggers are currently tracked through:

- triggered_skills
- enablers

Target State:

DamageChainRecord should explicitly model:

- damage_sources
- triggers
- enablers
- amplifiers
- supports

Goals:

1. Separate Trigger classification from Enabler classification.
2. Preserve Rule 001 promotion behaviour.
3. Maintain relationship-driven detection.
4. Avoid skill-name specific logic.
5. Validate classification using:
   - Cast on Critical
   - Cast on Shock
   - Cast on Freeze
   - Lightning Rod
   - Totem builds

Expected Outcome:

The optimizer understands not only which skills contribute damage, but also the role each skill performs within the build ecosystem.

Do not rank contributors or optimize rotations
in this phase.

# Prior Phase 4B Progress Record (Historical)

4B-1 Foundations                COMPLETE
4B-2 Relationship Discovery     COMPLETE
4B-3 Damage Chain Resolution    COMPLETE
4B-4A Record Refactor           COMPLETE
4B-4B Triggered Skill Promotion COMPLETE
4B-4C Relationship Classification SUPERSEDED BY PHASE 4B

Historical Focus (superseded by the authoritative status above):

Implement the Phase 4A PoBSkillDatabase design. Relationship Discovery 2.0
follows only after that database exists.