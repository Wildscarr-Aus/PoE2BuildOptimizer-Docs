#=====================================================================
#
# SYSTEM_ARCHITECTURE_REGISTER.md
#
# PoE2 Build Optimizer
#
# Authoritative Repository Architecture Record
#
# Purpose:
#     Records what exists in the codebase,
#     where responsibilities live,
#     dependency relationships,
#     lifecycle status,
#     and architectural classifications.
#
# Companion Document:
#     PROJECT_KNOWLEDGE_BASE.md
#
# Status:
#     Repository Audit Complete
#
# Version:
#     1.0
#
#=====================================================================



#=====================================================================
#
# DOCUMENT METADATA
#
#=====================================================================

Project:

    PoE2 Build Optimizer

Repository Audit Status:

    COMPLETE

Audit Scope:

    Archived/
    Config/
    Data/
    Dev/
    Docs/
    Src/Core/
    Src/Graph/
    Src/Io/
    Src/Analysis/
    Src/Audit/
    Src/Optimization/
    Tests/

Companion Document:

    PROJECT_KNOWLEDGE_BASE.md

Purpose:

    PROJECT_KNOWLEDGE_BASE.md
        = What we know

    SYSTEM_ARCHITECTURE_REGISTER.md
        = What exists



#=====================================================================
#
# SECTION 1 - PROJECT PHASE STATUS
#
#=====================================================================

Phase 1

    Tree Auditor

Status

    COMPLETE

------------------------------------------------------------

#=====================================================================
# GRAPHBUILDER
#=====================================================================

Purpose

    Build and maintain the authoritative
    passive tree graph representation.

Responsibilities

    Travel graph generation

    Edge generation

    Connectivity analysis

    Graph services

------------------------------------------------------------
GRAPHBUILDER V2
------------------------------------------------------------

Owns

    travel graph

    special_access_nodes

    conditional_nodes

    unlock_constraints

Registry Types

    special_access_nodes
        set[int]

    conditional_nodes
        set[int]

    unlock_constraints
        dict[int, dict]

Registry Counts (Current Audit)

    special_access_nodes
        22

    conditional_nodes
        200

    unlock_constraints
        200

Important Findings

    unlockConstraint is a dependency
    relationship and not a travel edge.

    special_access_nodes are derived as:

        all_nodes - graph_nodes

Consumers

    Pathfinder

    Optimizer Engine

    TreeAuditor

------------------------------------------------------------

Phase 3

    Pathfinder

Status

    Foundation Complete

------------------------------------------------------------

Phase 4

    Optimizer Engine

Status

    Prototype Exists
    Architectural Rewrite Required

------------------------------------------------------------

Phase 5

    UI

Status

    Not Started

------------------------------------------------------------

Phase 6

    Installer & Deployment

Status

    Not Started



#=====================================================================
#
# SECTION 2 - PROTECTED ARCHITECTURE ASSETS
#
#=====================================================================

The following components are considered
protected architecture assets.

Refactor Carefully.

Do Not Delete.

Do Not Replace.

------------------------------------------------------------

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
# SECTION 3 - ARCHITECTURE LAYERS
#
#=====================================================================

------------------------------------------------------------
INFRASTRUCTURE LAYER
------------------------------------------------------------

Files

    Src/Core/Config/paths.py

    Src/Core/Versioning/version_detector.py

    Src/Io/gem_loader.py

    Src/Io/pob2_exporter.py

Responsibilities

    Path Management

    Version Discovery

    Version-Aware Paths

    Gem Loading

    Build Exporting

------------------------------------------------------------
DOMAIN LAYER
------------------------------------------------------------

Files

    Src/Core/build_model.py

    Src/Core/passive_tree.py

    Src/Core/passive_lookup.py

    Src/Core/class_start_lookup.py

    Src/Core/jewel_rule_parser.py

    Src/Core/tree_rule_manager.py

Responsibilities

    Build Modeling

    Tree Modeling

    Node Lookup

    Class Start Lookup

    Rule Parsing

    Rule Resolution

    Build Profile Modeling

    Skill Group Modeling

    Weapon Set Modeling

------------------------------------------------------------
GRAPH LAYER
------------------------------------------------------------

Files

    Src/Graph/graph_builder.py

    Src/Graph/pathfinder.py

Responsibilities

    Travel Graph

    Adjacency Graph

    Connectivity

    Reachability

    Pathfinding

Future Expansion

    Unlock Graph

    Conditional Graph

    Special Access Graph

------------------------------------------------------------
AUDIT LAYER
------------------------------------------------------------

Files

    Src/Audit/tree_auditor.py

Responsibilities

    Node Accounting

    Missing Node Detection

    Conditional Analysis

    Graph Validation

    Audit Exports

------------------------------------------------------------
ANALYSIS LAYER
------------------------------------------------------------

Files

    Src/Analysis/allocated_node_analyzer.py

    Src/Core/analysis_result.py

    Src/Analysis/gem_validator.py

Responsibilities

    Connectivity Analysis

    Build Analysis

    Reachability

    Gem Validation

------------------------------------------------------------
OPTIMIZATION LAYER
------------------------------------------------------------

Files

    Src/Optimization/scoring.py

    Src/Optimization/optimizer.py

    Src/Analysis/auto_weighting.py

    Src/Analysis/build_evaluator.py

Status

    Prototype

Future

    Rewrite Logic

    Retain Architecture

------------------------------------------------------------
QUALITY ASSURANCE LAYER
------------------------------------------------------------

Directory

    Tests/

Responsibilities

    Regression Testing

    Integration Testing

    Graph Validation

    Rule Validation

    Build Validation

    Acceptance Testing

Status

    Active



#=====================================================================
#
# SECTION 4 - CURRENT DEPENDENCY CHAIN
#
#=====================================================================

paths.py
        ↓

version_detector.py
        ↓

tree.json
        ↓

PassiveLookup
        ↓

ClassStartLookup
        ↓

JewelRuleParser
        ↓

TreeRuleManager
        ↓

ResolvedTreeRules
        ↓

PassiveTreeGraph
        ↓

GraphBuilder
        ↓

Pathfinder
        ↓

AllocatedNodeAnalyzer
        ↓

BuildEvaluator
        ↓

Optimizer



#=====================================================================
#
# SECTION 5 - DIRECTORY CLASSIFICATION
#
#=====================================================================

------------------------------------------------------------
PRODUCTION DIRECTORIES
------------------------------------------------------------

Src/Core/

Src/Graph/

Src/Io/

Src/Audit/

Src/Analysis/

------------------------------------------------------------
PROTOTYPE DIRECTORIES
------------------------------------------------------------

Src/Optimization/

------------------------------------------------------------
VALIDATION DIRECTORIES
------------------------------------------------------------

Tests/

------------------------------------------------------------
DOCUMENTATION DIRECTORIES
------------------------------------------------------------

Docs/

(Currently Empty)

------------------------------------------------------------
HISTORICAL DIRECTORIES
------------------------------------------------------------

Dev/

Archived/



#=====================================================================
#
# SECTION 6 - ACTIVE FILE INVENTORY
#
#=====================================================================

------------------------------------------------------------
CRITICAL RUNTIME COMPONENTS
------------------------------------------------------------

paths.py

version_detector.py

build_model.py

passive_tree.py

passive_lookup.py

class_start_lookup.py

jewel_rule_parser.py

tree_rule_manager.py

graph_builder.py

pathfinder.py

pob2_importer.py

tree_auditor.py

------------------------------------------------------------
HIGH VALUE SUPPORT COMPONENTS
------------------------------------------------------------

allocated_node_analyzer.py

analysis_result.py

gem_loader.py

gem_validator.py

pob2_exporter.py



#=====================================================================
#
# SECTION 7 - LEGACY COMPONENTS
#
#=====================================================================

------------------------------------------------------------
SUPERSEDED
------------------------------------------------------------

Src/Core/tree_rules.py

Replaced By

    ResolvedTreeRules

------------------------------------------------------------
LEGACY
------------------------------------------------------------

Src/Io/pob2_detection.py

Replaced By

    VersionContext

------------------------------------------------------------
ARCHIVED
------------------------------------------------------------

Src/Io/gem_database.py

Src/Analysis/tree_version_detector.py

Src/Analysis/versioned_data_loader.py

Dev/Tools/data_import.py

Dev/Tools/tree_downloader.py

Dev/Tools/tree_xml_to_json.py



#=====================================================================
#
# SECTION 8 - ARCHITECTURAL DISCOVERIES
#
#=====================================================================

------------------------------------------------------------
DISCOVERY 1
------------------------------------------------------------

Passive Definition

!=

Passive Instance

Passive Definition

    name

    stats

Passive Instance

    node_id

    skill

    group

    orbit

    orbitIndex

    connections

------------------------------------------------------------
DISCOVERY 2
------------------------------------------------------------

unlockConstraint

!=

Travel Connection

Unlock dependencies and traversal
connections are separate systems.

------------------------------------------------------------
DISCOVERY 3
------------------------------------------------------------

Special Access Nodes Exist

Count

    22

------------------------------------------------------------
DISCOVERY 4
------------------------------------------------------------

Conditional Nodes Exist

Count

    200

------------------------------------------------------------
DISCOVERY 5
------------------------------------------------------------

Tree Auditor

is a permanent subsystem.

Not a temporary investigation.

------------------------------------------------------------
DISCOVERY 6
------------------------------------------------------------

Signature Layer Exists

Passive Definition Layer

    Name + Stats

Node Instance Layer

    Node Placement + Connectivity

Optimizer should eventually score:

    Definitions

GraphBuilder should model:

    Instances

------------------------------------------------------------
DISCOVERY 7
------------------------------------------------------------

Damage Chain Exists

Build optimisation cannot rely solely
upon a single primary skill.

Examples:

Arc Totem
    → Arc
    → Damage

Cast on Crit
    → Frost Bomb
    → Exposure
    → Damage

Future optimisation must evaluate
damage chains rather than isolated skills.

------------------------------------------------------------
DISCOVERY 8
------------------------------------------------------------

Weapon Sets Are Independent Paths

Weapon Set 1 and Weapon Set 2 maintain
independent passive allocations.

Rules:

    WS1 pathing only supports WS1

    WS2 pathing only supports WS2

    Shared nodes may support both

Weapon Set allocations are not
node-for-node paired.

------------------------------------------------------------
DISCOVERY 9
------------------------------------------------------------

Weapon Set Pool Accounting Exists

Current understanding:

    Pool Size =
        max(WS1 Allocations,
            WS2 Allocations)

Weapon set accounting appears to
operate on allocation counts rather
than node pairings.

Further validation required.

------------------------------------------------------------
DISCOVERY 10
------------------------------------------------------------

Installed Tree Version Is Authoritative

Optimization data should be sourced
from the installed TreeData version.

Priority:

    Installed Version
        Critical

    Build Tree Version
        Important

    Build Target Version
        Informational

#=====================================================================
#
# SECTION 9 - TEST SUITE CLASSIFICATION
#
#=====================================================================

------------------------------------------------------------
TIER 1
CRITICAL REGRESSION TESTS
------------------------------------------------------------

test_importer.py

test_lookup.py

test_passive_lookup.py

test_graph_builder.py

test_class_start_lookup.py

test_rules.py

test_tree_rules.py

test_resolved.py

test_analyzer.py

test_tree_audit.py

------------------------------------------------------------
TIER 2
INTEGRATION TESTS
------------------------------------------------------------

test_connected_tree.py

test_pathfinder.py

test_all.py

------------------------------------------------------------
TIER 3
HISTORICAL INVESTIGATION SCRIPTS
------------------------------------------------------------

test_missing_connections.py

test_node_id_mapping.py

test_node_investigation.py

test_ascendancy_nodes.py

tree_json_explorer.py

tree_node_probe.py

------------------------------------------------------------
TIER 4
ARCHIVE CANDIDATES
------------------------------------------------------------

class_probe.py

test_manager_methods.py

------------------------------------------------------------
TIER 5
QUALITY ASSURANCE
------------------------------------------------------------

QA Coverage

    Import Pipeline

    Rule Resolution

    Graph Construction

    Pathfinder

    Tree Auditor

    Class Start Resolution

    Passive Lookup

    Regression Validation

#=====================================================================
#
# SECTION 10 - REFACTOR BACKLOG
#
#=====================================================================

------------------------------------------------------------
HIGH PRIORITY
------------------------------------------------------------

Remove Duplicate Pathfinder

Current

    Src/Optimization.optimizer.Pathfinder

    Src/Graph.pathfinder.Pathfinder

Target

    Src/Graph.pathfinder.Pathfinder

------------------------------------------------------------

Exporter Migration

Current

    Hardcoded Versions

Target

    VersionContext

------------------------------------------------------------

Audit Consolidation

Target

    Src/Audit/

owns all audit systems.

------------------------------------------------------------

Version Context Adoption

Remove remaining dependencies on:

    pob2_detection.py

    versioned_data_loader.py



#=====================================================================
#
# SECTION 11 - INSTALLER TARGET ARCHITECTURE
#
#=====================================================================

Installer Responsibilities

    PoB2 Detection

    Version Detection

    Directory Creation

    Configuration

    Setup

------------------------------------------------------------

Optimizer Executable Responsibilities

    Import

    Rule Resolution

    Tree Analysis

    Graph Construction

    Pathfinding

    Optimization

    Export

------------------------------------------------------------

Architectural Rule

    Optimizer executable should not
    perform installer responsibilities.



#=====================================================================
#
# SECTION 12 - CURRENT PROJECT ASSESSMENT
#
#=====================================================================

Tree Auditor

    Ready

------------------------------------------------------------

GraphBuilder

    Strong Foundation

------------------------------------------------------------

Pathfinder

    Strong Foundation

------------------------------------------------------------

Optimizer

    Prototype

------------------------------------------------------------

UI

    Future

------------------------------------------------------------

Installer

    Future



#=====================================================================
#
# SECTION 13 - REPOSITORY AUDIT HISTORY
#
#=====================================================================

Repository Audit v1

Status

    Complete

Directories Audited

    Archived/

    Config/

    Data/

    Dev/

    Docs/

    Src/Core/

    Src/Graph/

    Src/Io/

    Src/Analysis/

    Src/Audit/

    Src/Optimization/

    Tests/

Major Outcome

    Repository architecture classified.

    Protected assets identified.

    Roadmap validated.

    Optimizer identified as primary
    future risk area.



#=====================================================================
#
# SECTION 14 - CHANGE LOG
#
#=====================================================================

Version 1.0

    Initial repository architecture audit.

    Full repository classification completed.

    Protected Architecture Assets identified.

    Dependency chain documented.

    Layer model documented.

    Refactor backlog established.

    Installer architecture documented.

    Project phase assessment recorded.



#=====================================================================
#
# FINAL ARCHITECTURAL VERDICT
#
#=====================================================================

The repository contains production-quality foundations for:

    Versioning

    Importing

    Rule Resolution

    Lookup Services

    Tree Modeling

    Graph Construction

    Pathfinding

    Auditing

------------------------------------------------------------

The highest-risk future work is:

    Optimizer Engine Rewrite

which must correctly incorporate:

    Passive Definitions

    Damage Chains

    Skill Relationships

    Weapon Set Allocations

    Weapon Set Pool Rules

    unlockConstraint

    Special Access Nodes

    Conditional Nodes

    Travel Cost

    Granted Nodes

    Additional Starts

    Rule-Aware Traversal

------------------------------------------------------------

Repository Audit Status

    COMPLETE

Document Status

    ACTIVE

Document Role

    Authoritative Architecture Record

Companion Document

    PROJECT_KNOWLEDGE_BASE.md

Version

    1.0