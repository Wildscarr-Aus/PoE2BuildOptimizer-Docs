#===========================================================
#
# PROJECT PRINCIPLES
#
#===========================================================

Purpose

    Defines the non-negotiable standards,
    architectural direction, and long-term
    vision of the project.

------------------------------------------------------------

Principle

    User is Project Architect

Meaning

    Discussions should focus on:

        Architecture

        Validation

        Requirements

        System Design

    rather than day-to-day coding.

------------------------------------------------------------

Principle

    Investigation Before Implementation

Meaning

    New discoveries must follow:

        Investigate
            ↓
        Document
            ↓
        Validate
            ↓
        Implement

    Never implement based solely
    on assumptions.

------------------------------------------------------------

Principle

    Tree Audit is First-Class

Meaning

    Audit functionality is permanent.

    Not temporary.

------------------------------------------------------------

Principle

    Passive Definitions
    !=
    Passive Instances

Meaning

    Optimizer scores definitions.

    GraphBuilder models instances.

------------------------------------------------------------

Principle

    Damage Chain First

Meaning

    Optimisation should understand
    the complete damage chain rather
    than a single skill.

Examples

    Arc Totem
        ↓
    Arc
        ↓
    Damage

    Cast on Crit
        ↓
    Frost Bomb
        ↓
    Exposure
        ↓
    More Damage

------------------------------------------------------------

Principle

    Build Reality

Meaning

    V1 optimises the build the player
    currently has.

    Fixed Inputs:

        Equipment

        Skills

        Support Gems

        Jewels

        Ascendancy

        Weapon Sets

    Optimised Component:

        Passive Tree

------------------------------------------------------------

Principle

    Build Continuity

Meaning

    Improve the imported build without
    changing its identity.

Allowed:

    Better DPS

    Better Defence

    Better Sustain

    Better Passive Allocation

Not Allowed:

    Converting the build into a
    different archetype.

------------------------------------------------------------

Principle

    Weapon Sets Are First-Class

Meaning

    Weapon Set 1 and Weapon Set 2 are
    part of the build and must be
    preserved.

Rules

    Independent pathing.

    Shared node support.

    Pool-based accounting.

    No assumptions about node pairing.

------------------------------------------------------------

Principle

    Installed Tree Version Is Authoritative

Meaning

    Optimization data comes from the
    installed TreeData version.

Priority

    Installed Tree Version
        Critical

    Build Tree Version
        Important

    Build Target Version
        Informational Only

------------------------------------------------------------

Principle

    Installer Owns Setup

Meaning

    Optimizer executable does not
    perform installation tasks.

------------------------------------------------------------

Principle

    Distribution Target

Meaning

    End users install an executable.

    No Python required.

------------------------------------------------------------

Principle

    UI First

Meaning

    Final workflow begins from UI.

------------------------------------------------------------

Principle

    Optimizer First

Meaning

    The optimizer is always the source
    of truth.

 