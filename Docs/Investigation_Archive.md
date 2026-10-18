#=====================================================================
#
# INVESTIGATION_ARCHIVE.md
#
# PoE2 Build Optimizer
#
# Authoritative Investigation History
#
# Purpose:
#
#     Preserve completed investigations,
#     findings, evidence, methodologies,
#     and conclusions.
#
# Companion Documents:
#
#     PROJECT_KNOWLEDGE_BASE.md
#
#     SYSTEM_ARCHITECTURE_REGISTER.md
#
#     PROJECT_ROADMAP.md
#
#=====================================================================



#=====================================================================
#
# DOCUMENT PURPOSE
#
#=====================================================================

PROJECT_KNOWLEDGE_BASE.md

    What we know.

------------------------------------------------------------

SYSTEM_ARCHITECTURE_REGISTER.md

    What exists.

------------------------------------------------------------

PROJECT_ROADMAP.md

    What happens next.

------------------------------------------------------------

INVESTIGATION_ARCHIVE.md

    How discoveries were proven.

------------------------------------------------------------

Completed investigations should be moved
here once their conclusions become stable.

The Knowledge Base should retain only:

    Discovery summaries

    Architectural rules

    Current project implications

The detailed evidence belongs here.



#=====================================================================
#
# SECTION 1
# TREE AUDIT PROGRAM
#
#=====================================================================

Status

    Complete

Purpose

    Validate tree integrity.

Goals

    Account for all nodes.

    Validate graph construction.

    Identify unknown node categories.

    Identify special node behavior.

Major Findings

    Tree Auditor justified promotion to
    first-class subsystem.

    Graph validation became permanent.

Outputs

    tree_audit.json

    summary.txt

Architectural Impact

    Audit subsystem retained permanently.

Reference

    See Data/Audits/<version>/



#=====================================================================
#
# SECTION 2
# UNKNOWN NODE INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    What are "unknown" nodes?

Method

    Classification analysis.

    Metadata inspection.

    Field comparison.

Conclusion

    Most unknown nodes are actually:

        Standard Passives

Additional Categories Discovered

    IMAGE_ONLY

    ACTIVE_EFFECT_IMAGE

    ASCENDANCY_OVERLAY

    SWITCHABLE

    MULTIPLE_CHOICE_OPTION

    CLASS_START

Architectural Impact

    Unknown node count significantly reduced.

    Tree classification logic improved.



#=====================================================================
#
# SECTION 3
# CLASS START INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    How are class start nodes represented?

Method

    tree.json analysis

    classesStart inspection

    node mapping

Conclusion

    Stable class start mapping exists.

Discovery

    Class Start Lookup service created.

Results

    Class → Node mapping

    Node → Class mapping

Architectural Impact

    Led directly to:

        ClassStartLookup

Protected Asset

    Yes



#=====================================================================
#
# SECTION 4
# NODE ID MAPPING INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    What identifiers should be
    considered authoritative?

Method

    Node key analysis

    Skill ID analysis

    Connection analysis

Findings

    node_id

    skill

    connection identifiers

must be treated carefully.

Outcome

    GraphBuilder requirements updated.

Architectural Impact

    Improved node resolution strategy.



#=====================================================================
#
# SECTION 5
# MISSING CONNECTION INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    Do all node references resolve?

Method

    Connection validation

    Graph consistency checks

Findings

    Missing references identified.

Impact

    GraphBuilder validation strengthened.

Related Component

    Tree Auditor



#=====================================================================
#
# SECTION 6
# CONDITIONAL NODE INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    How many conditional nodes exist?

Method

    unlockConstraint analysis

    Tree-wide inspection

Results

    Approximately 200 conditional nodes.

Key Discovery

    Conditional pathing exists.

Architectural Impact

    Pathfinder must become
    rule-aware.

Related Systems

    Tree Auditor

    GraphBuilder

    Pathfinder



#=====================================================================
#
# SECTION 7
# SPECIAL ACCESS INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    Do non-standard access nodes exist?

Results

    22 special access nodes discovered.

Conclusion

    Travel graph alone is insufficient.

Architectural Impact

    GraphBuilder must eventually
    model special access behavior.



#=====================================================================
#
# SECTION 8
# UNLOCK CONSTRAINT INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    What does unlockConstraint represent?

Method

    Tree-wide constraint analysis

Results

    unlockConstraint

        !=

    Travel Connection

Examples

    Oracle-gated nodes

    Ascendancy capstones

Conclusion

    Dependency graph is separate from
    traversal graph.

Architectural Impact

    Future graph model requires:

        Travel Graph

        Unlock Graph



#=====================================================================
#
# SECTION 9
# PASSIVE DEFINITION VALIDATION
#
#=====================================================================

Status

    Complete

Question

    Which fields define a passive?

Method

    Duplicate comparison

    Metadata classification

Results

Strong Definition Candidates

    name

    stats

Strong Instance Candidate

    skill

Conclusion

    Passive meaning is independent of
    physical tree placement.

Architectural Impact

    Definition layer required.



#=====================================================================
#
# SECTION 10
# PASSIVE SIGNATURE INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    Can passive definitions be
    represented independently of nodes?

Method

    Signature grouping

    Duplicate analysis

Results

    4,914 total nodes

    2,228 unique signatures

    692 duplicate signature groups

Key Discovery

    Passive Definition

        !=

    Passive Instance

Definition

    name

    stats

Instance

    node id

    group

    orbit

    orbitIndex

    connections

Architectural Impact

    Future Optimizer should score:

        Passive Definitions

    GraphBuilder should model:

        Passive Instances

Importance

    Extremely High



#=====================================================================
#
# SECTION 11
# ORACLE INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    How should Oracle-specific nodes
    be modeled?

Findings

    Oracle nodes frequently contain
    modified stat packages.

Example

    Generic passive

        +10%

    Oracle version

        +15%

Conclusion

    Oracle variants are separate
    passive definitions.

Architectural Impact

    Signature system validated.



#=====================================================================
#
# SECTION 12
# RULE SYSTEM INVESTIGATION
#
#=====================================================================

Status

    Complete

Question

    How should jewel rules be resolved?

Investigated

    Granted Nodes

    Additional Starts

    Radius Allocation

Result

    TreeRuleManager created.

Output

    ResolvedTreeRules

Architectural Impact

    Rule resolution occurs before
    graph traversal.

Protected Asset

    Yes



#=====================================================================
#
# SECTION 13
# GRAPHBUILDER DISCOVERY SUMMARY
#
#=====================================================================

Final Conclusions

GraphBuilder must eventually model:

    Travel Connections

    Conditional Nodes

    Unlock Dependencies

    Special Access Nodes

------------------------------------------------------------

GraphBuilder must not assume:

    unlockConstraint
        =
    Traversal

------------------------------------------------------------

GraphBuilder operates on:

    Node Instances

------------------------------------------------------------

Optimizer evaluates:

    Passive Definitions



#=====================================================================
#
# SECTION 14
# PATHFINDER DISCOVERY SUMMARY
#
#=====================================================================

Final Conclusions

Pathfinder must eventually support:

    Additional Starts

    Granted Nodes

    Conditional Nodes

    Special Access Nodes

    Unlock Constraints

    Travel Cost

Current State

    Foundation Complete

Future State

    Rule-Aware Traversal Engine



#=====================================================================
#
# SECTION 15
# OPTIMIZER DISCOVERY SUMMARY
#
#=====================================================================

Current Assessment

    Prototype Exists

Primary Risks

    Travel Cost Modeling

    Rule Integration

    Unlock Dependencies

    Passive Definitions

    Granted Nodes

    Additional Starts

Target Optimizer Inputs

    Passive Definitions

    GraphBuilder

    Pathfinder

    ResolvedTreeRules

    VersionContext

Conclusion

    Optimizer remains the largest
    remaining technical challenge.

#=====================================================================
#
# SECTION 16
# QUALITY ASSURANCE STRATEGY
#
#=====================================================================

Status

    Adopted

Purpose

    Formalize validation before release.

Motivation

    Repository audit demonstrated
    significant value from:

        Regression Tests

        Integration Tests

        Validation Investigations

        Audit Tools

Conclusion

    QA promoted to a dedicated
    roadmap phase.

Architectural Impact

    QA no longer considered a
    supporting activity.

    QA now considered a project phase.

#=====================================================================
#
# INVESTIGATION INDEX
#
#=====================================================================

Completed Investigations

    Tree Audit

    Unknown Node Classification

    Class Start Discovery

    Node ID Mapping

    Missing Connection Analysis

    Conditional Node Analysis

    Special Access Analysis

    unlockConstraint Analysis

    Passive Definition Validation

    Passive Signature Investigation

    Oracle Investigation

    Rule System Investigation

------------------------------------------------------------

Future Investigations

    Optimizer Heuristics

    Travel Cost Modeling

    Build Scoring Models

    Passive Definition Catalog

    Full Unlock Graph Construction



#=====================================================================
#
# CHANGE LOG
#
#=====================================================================

Version 1.0

    Initial archive created.

    Repository audit findings migrated.

    Completed investigations catalogued.

    Discovery history preserved.

# Investigation Archive Update - 2026-10-08

Phase 4B-3 Investigation

Areas Investigated:

- Skill Chains
- Damage Chains
- Weapon Sets
- Version Handling
- V1 Optimisation Scope

------------------------------------------------------------

Damage Chain Findings

Primary Skill is likely insufficient for
build classification and optimisation.

Current working model:

Damage Source
Damage Enabler
Damage Amplifier

Examples:

Arc Totem
    -> Arc
    -> Damage

Cast on Crit
    -> Frost Bomb
    -> Exposure
    -> More Damage

Conclusion:

Optimizer should understand the primary
damage chain rather than a single skill.

------------------------------------------------------------

Version Findings

Installed Tree Version
    - Critical
    - Source of optimisation data

Build Tree Version
    - Important
    - Compatibility reference

Build Target Version
    - Informational only

Target Version may be useful later for:

- Build guides
- Progression tracking
- Historical build context

No V1 optimisation logic should depend
on Build Target Version.

------------------------------------------------------------

Weapon Set Investigation

Confirmed weapon set passives are not
extra passive points.

Weapon set points are created by converting
normal passive points.

WS1 and WS2 maintain independent pathing.

Rules:

WS1 pathing only satisfies WS1.

WS2 pathing only satisfies WS2.

Shared nodes may satisfy both.

------------------------------------------------------------

Weapon Set Pool Findings

Current understanding:

Pool Size =
max(WS1 allocations, WS2 allocations)

Example:

WS1 = 14
WS2 = 5

Pool = 14

Meaning:

14 passive points have been converted
into weapon-set points.

Weapon-set nodes are not paired
node-for-node.

The order of WS1 and WS2 allocations
does not matter.

Allocation counts matter more than
individual node pairings.

Refunds appear to be pool based.

Current observed maximum:

24 weapon-set points.

Future investigation required.

------------------------------------------------------------

Weapon Set Activation

Weapon set passives activate with the
currently active weapon configuration.

Weapon changes may occur via:

- Manual weapon swap
- Skill-driven weapon selection

Result:

Different passive allocations may become
active during gameplay.

------------------------------------------------------------

BuildModel Investigation

No architecture changes approved yet.

Action item:

Verify whether BuildModel already stores:

- Shared Nodes
- WeaponSet1 Nodes
- WeaponSet2 Nodes

before making structural changes.

------------------------------------------------------------

V1 Scope Findings

V1 should optimise:

Passive Tree Only

The following remain fixed:

- Equipment
- Skills
- Support Gems
- Jewels
- Ascendancy
- Weapon Set Structure

User defined constraints may include:

- Full Respec
- 20 Point Optimisation
- 50 Point Optimisation
- Maximum DPS
- Maximum Defence
- Maximum Regen

------------------------------------------------------------

Future Vision Recorded

AI Build Guide (V3+)

Potential capabilities:

- Build Explanations
- Leveling Plans
- League Starter Guidance
- Build Timelines
- Build Transition Planning

Design Principle:

Optimizer = Source of Truth

AI = Explanation and Planning Layer

AI remains:

- Optional
- User Authorised
- Provider Agnostic
- Not Developer Funded

------------------------------------------------------------

Damage Chain Investigation Milestone

First live build analysed:

    Whirling twisters.xml

Primary Skill:

    Twister

Damage Source:

    Twister

Major Findings:

- Damage Chain pipeline validated.
- Primary skill selection appears correct.
- Relationship classifications currently mostly UNKNOWN.
- Twister interacts with elemental ground effects.
- Whirling Slash interacts with elemental ground effects.
- Frozen Mandibles can participate in the damage system via ground effects.
- PoE2 builds appear to be mechanic networks rather than simple skill collections.

# Investigation Update - 2026-10-15

Phase 4B-4A is complete. DamageChainRecord was extracted from
damage_chain_resolver.py into damage_chain_record.py as the canonical
damage-chain model. DamageChainResolver remains in
damage_chain_resolver.py and owns resolution. The record now includes
a damage_sources collection. Resolver, report, and record tests passed:
25 tests after the refactor.

Phase 4B-4B is partially complete. Triggered Skill Promotion is implemented:
triggered skills are promoted as additional damage-source candidates while
existing candidates remain preserved. Twister, Cast on Crit, and
Totem/enabler validation pass, with 13 DamageChainResolver tests passing.

Remaining work is the formal relationship classification layer, including
trigger classification, amplifier classification, and separation of
Triggers vs Enablers. Contributor ranking and rotation analysis remain out
of scope.

## Multi-source and Trigger Promotion Findings

Real builds can contain multiple meaningful damage sources. Triggered
skills should be promoted as additional damage-source candidates, not
used to replace existing contributors.

## Revised Rule 001

Triggered Skill Promotion

Status:

IMPLEMENTED AND VALIDATED

Definition:

When A TRIGGERS B:

- Promote B to a damage-source candidate.
- Keep existing damage-source candidates.
- Preserve the trigger relationship and enablers.

Validation Status:

PASSING

Validated By:

- Triggered meta-skill promotion test.
- Multi-source promotion test.
- Twister + triggered skill validation.

Examples:

- Twister builds may have Twister and ground-effect damage components.
- Cast on Critical builds may have a primary skill and triggered damage skills.
- Lightning Arrow can contribute damage while Comet is a triggered damage
  candidate; Lightning Rod can be an enabler or amplifier of critical-hit
  generation.

Classification distinguishes:

- Damage sources: skills that directly contribute meaningful damage.
- Triggers: skills or mechanics that activate other skills.
- Enablers: skills or mechanics required for damage generation.
- Amplifiers: skills or mechanics that increase effectiveness.
- Supports: traditional support relationships.

Detection must be relationship-driven using RelationshipType values such as
TRIGGERS, ENABLES, AMPLIFIES, and SUPPORTS. Avoid skill-name-specific rules.
Future game-specific behavior belongs in metadata and the future Skill /
Support / Mechanic Rules Engine.

Contributor ranking and rotation analysis are not part of Phase 4B-4B;
rotation analysis remains future optimization-phase work.

## Investigation Update — 2026-10-18

### Skill Role and Viability Design

Phase 4D.3 separates capability, build-local role, investment, importance,
and viability. A skill may have multiple roles; low support count does not
prove low importance, and damage capability does not prove that the build
invests in or relies on the skill. The design is documented in
`Data/Reports/Phase_4D_3_Skill_Role_And_Viability_Design.md`.

### Evidence Schema Validator

The Evidence Schema validator is implemented using JSON Schema Draft
2020-12 and supports `evidence_version` 2.0.0. Validation, collection
lineage checks, and an append-only in-memory ledger are covered by tests.
The complete suite passed with 368 tests. The validator contract's required
fields and vocabularies differ from portions of the Phase 4D.3 proposal.
That mismatch remains an explicit contract-reconciliation gate; evidence
producers must not adopt either contract by assumption.

### Real-Build Review Findings

- Whirling Twisters has four structurally validated Cast on Critical trigger
  edges to Profane Ritual, Elemental Weakness, Frost Bomb, and Flame Wall.
- Boundless Energy II directly supports Cast on Critical; its paths to the
  triggered targets remain indirect and unresolved. Do not infer propagation.
- Herald skills were emitted as secondary-damage chains despite the reviewed
  mechanics evidence not declaring `Damage` or `DamageOverTime`. Treat these
  as suspicious classifications for evidence-backed follow-up, not as a
  reason for skill-name-specific logic.
- Spin to Win Monk, Whirling Twisters, and Gemling Firesmasher remain the
  validation fixtures for role/viability and damage-source review.

----------

#=====================================================================
#
# END OF INVESTIGATION ARCHIVE
#
#=====================================================================