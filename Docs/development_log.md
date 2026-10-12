2026-10-07

Completed

    GraphBuilder V2 Step 1A
        Registry containers

    GraphBuilder V2 Step 1B
        Registry population

Validated

    special_access_nodes = 22

    conditional_nodes = 200

    unlock_constraints = 200

Audit parity achieved.

# Development Log - 2026-10-08

Completed further Phase 4B-3 investigation work.

Skill chain investigation continues. Current understanding is that optimisation should focus on the primary damage chain rather than a single primary skill.

Examples:

Arc Totem -> Arc -> Damage

Cast on Crit -> Frost Bomb -> Exposure -> More Damage

V1 Scope Clarified:

- Optimise passive tree only
- Equipment remains fixed
- Skills remain fixed
- Supports remain fixed
- Jewels remain fixed
- Ascendancy remains fixed
- Weapon set structure remains fixed

User constraints may include:

- Full respec
- Within 20 points
- Within 50 points
- Maximum DPS
- Maximum Defence
- Maximum Regen

Version Handling:

Installed Tree Version
- Critical
- Source of optimisation data

Build Tree Version
- Important
- Compatibility reference

Build Target Version
- Informational only
- No V1 optimisation logic depends on it
- Potential V2/V3 feature for build progression or guide support

Weapon Set Investigation Findings:

- Weapon set points are NOT extra passive points
- Weapon set points are created by converting normal passive points
- WS1 and WS2 have independent pathing requirements
- WS1 cannot provide pathing to WS2
- WS2 cannot provide pathing to WS1
- Shared nodes can support both

Weapon Set Pool Rules:

Pool Size = max(WS1 allocations, WS2 allocations)

Example:

WS1 = 14
WS2 = 5

Pool = 14

This means 14 normal passive points have been converted into weapon set points.

Weapon set nodes are NOT paired node-for-node.

Allocation order between WS1 and WS2 does not matter.

Refund behaviour is pool based rather than node-pair based.

Current observed weapon set cap:

24 points

Weapon Set Activation:

- Weapon Set 1 passives activate when Weapon Set 1 is active
- Weapon Set 2 passives activate when Weapon Set 2 is active
- Skill usage may automatically activate a specific weapon set

BuildModel:

No changes planned at this stage.

Action item:
Confirm whether BuildModel already imports and stores:

- Shared nodes
- WeaponSet1 nodes
- WeaponSet2 nodes

before making architecture changes.

Future Vision Recorded:

Optional AI Build Guide (V3+)

Principles:

- Optimizer remains the source of truth
- AI acts as explanation and planning layer
- AI remains optional
- User authorization required
- No developer-funded AI required

Potential features:

- Build explanations
- Leveling plans
- Build timelines
- League starter guidance
- Transition planning

Next Session:

1. Update knowledge base
2. Implement skill_chain_report.py
3. Audit BuildModel weapon set support
4. Investigate weapon set import handling
5. Continue damage chain investigation