# Phase 4D.3 - Skill Role & Viability Design Investigation

**Status:** Design investigation only

**Scope:** Build-local skill capabilities, roles, investment, importance, viability, and shared evidence provenance. No implementation changes are made by this investigation.

## Executive Recommendation

The Build Understanding layer sits between imported build structure and the future Optimizer. Its output should explain the build snapshot without mutating it or deciding what to optimize. Do not classify a skill with one exclusive label such as “damage skill” or calculate one opaque “viability” score. Model distinct, evidence-linked questions:

1. **Capability:** What does authoritative mechanics data declare that this skill can do?
2. **Build role:** What function does this particular skill instance appear to perform in this build?
3. **Investment:** What configuration choices show the build is committed to this instance?
4. **Importance:** What evidence suggests the build depends on or prioritizes it?
5. **Viability/readiness:** Is the role configured and usable in the current build context, and is any outcome actually validated?

Keep facts separate from conclusions. Every derived role, classification, viability state, and future optimizer input must reference evidence records and the rule/version that derived it. Treat missing or unsupported evidence as **unknown**, not as proof that a skill cannot perform a role.

Roles should be multi-label and attached to build-local skill instances, not permanently assigned to skill names. A skill can be a persistent buff provider and a damage-over-time candidate, or a trigger provider and resource generator, without those roles implying one another.

The current real-build evidence supports recording configuration and structural participation, but not a universal importance score, realized contribution, or damage ranking. In particular, support counts are evidence of socket configuration and compatibility—not proof of effect, damage, or importance.

## Investigation Basis and Current Limitations

This design is grounded in the current [SkillIdentity model](../../Src/Analysis/skill_identity.py), [PoBSkillDatabase model](../../Src/Io/pob_skill_database.py), [Contributor Discovery](../../Src/Analysis/contributor_discovery.py), [Contributor Classification](../../Src/Analysis/contributor_classification.py), [Damage Chain Foundation](../../Src/Analysis/damage_chain_foundation.py), [DamageChainResolver](../../Src/Analysis/damage_chain_resolver.py), and the existing Phase 4D validation reports.

Observed constraints:

- `SkillRecord` contains build instance identity, enabled state, active skill-set/group references, weapon set, `include_in_full_dps`, primary-skill flags, gem identity, tags, and granted-effect identity. It has no explicit equipment-grant provenance, gem level, build-stage history, outcome value, or role assessment.
- `PoBSkillMechanicsRecord` retains declared types, support/trigger flags and expressions, source file/line, unsupported fields, and raw fields. The database is read-only and does not execute Lua or infer relationships. A declared type is a mechanics fact; it is not itself proof of an observed build outcome.
- Contributor Discovery uses validator-accepted `SUPPORTS` and `TRIGGERS` edges, retaining their endpoints and evidence. Contributor Classification currently labels path topology and structural/unresolved state; it does not establish effect propagation.
- The current Damage Chain Foundation treats any one of `Attack`, `Companion`, `Damage`, `DamageOverTime`, or `Minion` as source-candidate evidence. Therefore `Attack` alone can produce a damage-chain candidate. The chain is explicitly structural, but the candidate can be semantically overbroad.
- The legacy [ContributorModel](../../Src/Analysis/contributor_model.py) is only a container for contributor records. The legacy [ContributorBuilder](../../Src/Analysis/contributor_builder.py) assigns role/significance labels from the earlier damage-chain model and name-keyed relationships; it is not a substitute for the validated build-local relationship evidence.
- The current [DamageChainResolver](../../Src/Analysis/damage_chain_resolver.py) starts with the selected primary skill, returns early when no primary is selected, and uses `include_in_full_dps` groups as additional candidates. That is useful identity/configuration evidence but cannot fully represent multiple concurrent build roles or explain importance.

## 1. Capability Versus Build Role

These must be separate concepts.

### Capability

A capability is a mechanics or identity fact about a skill definition. It should retain the exact PoB mechanics record, identity join, source version, and declaration. Potential capability vocabulary includes:

- Action/form: `Attack`, `Spell`, `Melee`, `Projectile`, `Area`, `Channel`, `Minion`, `Companion`.
- Behavior: `Trigger`, `Buff`, `Herald`, `AppliesCurse`, `Mark`, `Persistent`.
- Resource/mechanic: `GeneratesEnergy`, `GeneratesCharges`, `ConsumesCharges`, `CreatesMinion`, `CreatesCompanion`, `CausesBurning`, `Damage`, `DamageOverTime`.

Do not flatten every capability into a Boolean “can damage.” For example, `Attack` describes a skill category, not sufficient evidence of damage being produced in the current build. `DamageOverTime` is a more direct declared damage-related capability, but still does not quantify whether or how much damage occurs in a particular build.

Capability evidence should distinguish:

- **Declared:** explicitly present in a uniquely resolved authoritative mechanics record.
- **Derived:** inferred by a versioned rule from declared fields; preserve the derivation and its parent evidence.
- **Unknown:** missing, ambiguous, unsupported, or not parsed. Unknown is not false.

Capability wording needs evidence-specific thresholds:

| Capability claim | Evidence needed | What the claim does not mean |
|---|---|---|
| **Attack / Spell / Projectile / Buff / Herald / Minion / Companion** | Exact declared mechanics type or identity fact, with source/version. | Does not by itself establish a role, a successful activation, or an outcome. |
| **Can Damage** | Explicit damage mechanic evidence (for example declared `Damage`/`DamageOverTime`) or a versioned derived rule whose parent evidence identifies the mechanics supporting it. | `Attack`, support compatibility, or a damage-like name alone is insufficient; capability does not establish build contribution. |
| **Can Trigger** | Explicit trigger capability/mechanics and, for build participation, a validated outgoing `TRIGGERS` relationship. | A generic `Meta` type alone does not prove trigger semantics; a declared trigger capability does not prove a target is actually configured. |
| **Can Support / Modify Skills** | Authoritative support identity/flag plus its requirements/exclusions; a build-local `SUPPORTS` edge is separate relationship evidence. | Being a support gem does not show that it supports a particular skill or that its effect applies. |
| **Can Buff / Debuff** | Explicit buff, curse, mark, or corresponding effect mechanics; target/application is separately evidenced. | `Buff`/`Mark` tags do not prove who receives an effect, for how long, or with what result. |
| **Can Generate/Consume Charges or Resources** | Explicit declared generation/consumption mechanics or a supported mechanics expression with traceable source. | Names, reservation/persistence, or generic `Buff` are not enough to identify a specific resource flow. |
| **Can Summon / Control Minions or Companions** | Explicit `CreatesMinion`/`CreatesCompanion` or supported control/ownership mechanics. | Does not prove which entity acts, its damage, or how outcomes are attributed. |

Capabilities should remain composable and may be related by explicitly modeled mechanics, but must not be chained transitively without evidence. For example, `TRIGGERS` relates skill activations; it does not imply that all effects, supports, or resource changes on the trigger provider transfer to its target.

### Build role

A role is a build-context interpretation for a particular skill instance. It should cite capability, relationship, contributor, investment, and build-context evidence as applicable. It may be absent or unresolved even when capabilities are known.

Examples:

- `Quarterstaff Strike`: the current build has an `Attack` capability and one accepted support relation. Its equipment-granted origin is a user-supplied interpretation, not a field currently represented by `SkillRecord`; it must not be asserted until explicit grant provenance is captured. This instance's role and investment do not define the same skill's role in a future build.
- `Herald of Ash`: the reviewed mechanics record declares `Buff`, `Herald`, `CausesBurning`, `Area`, and `DamageOverTime`. That supports multiple capability facts and possible roles, but does not decide whether this build uses it as a damage source, buff provider, or both.
- `Cast on Critical`: the mechanics record declares `Meta`, `Buff`, `GeneratesEnergy`, and `Triggers`. The build has one direct support and four validated trigger edges. These are evidence for a trigger-provider/resource-related role and structural centrality, not proof that Cast on Critical itself is a damage skill.

### Multiple simultaneous roles

Yes. A role assignment is an independent, potentially conditional relation between a skill instance and a build:

```text
BuildRoleAssignment
  skill_instance
  role
  scope / conditions
  evidence references
  status and unresolved reasons
```

Do not force one “main role” on each skill. A skill may hold multiple role assignments; roles may be conditional on weapon set, trigger state, resource availability, or build stage. “Primary” should remain a separate build selection or explicit priority signal, not silently override other roles.

## 2. Recommended Build Role Categories

| Candidate role | Current supportability | Evidence boundary |
|---|---|---|
| **Primary damage candidate** | Partial | Primary skill selection and mechanics identity exist. Selection is not proof of realized damage or importance. |
| **Secondary damage candidate** | Partial | Exact damage-related mechanics and build-local participation can support a candidate. The current `Attack`-inclusive source rule is too permissive to certify this role. |
| **Trigger provider** | Structural support exists | Use accepted outgoing `TRIGGERS` edges and mechanics facts. This proves a validated trigger relationship, not frequency or downstream effect. |
| **Triggered skill** | Structural support exists | Use accepted incoming `TRIGGERS` edges. Triggered status does not establish damage. |
| **Support / skill modifier** | Structural support exists | Use support identity and exact accepted `SUPPORTS` edges. Do not assume the supported effect applies or propagates. |
| **Buff provider / debuff provider** | Partial | Declared `Buff`, curse, or mark mechanics can evidence capability; target, duration, application, and realized effects need explicit mechanics/relationship modeling. |
| **Resource generator / consumer** | Partial | Explicit declared generation/consumption fields can evidence a capability. Do not infer a charge role from a name or from generic `Buff`/`Persistent` types. |
| **Minion / companion provider** | Partial | `CreatesMinion`/`CreatesCompanion` and identity support provider/ownership candidates. Ownership, action, damage, and attribution remain unmodeled. |
| **Equipment-granted skill** | Not currently evidenced by the inspected skill record | Requires source provenance linking a skill instance to the granting item/equipment effect. Gem type, skill name, or absence of a socketed gem is insufficient by itself. |
| **Utility** | Broad, weakly discriminating | Useful as an explicitly supported catch-all only when evidence exists. It should not be used as an inverse of “damage” or as a synonym for “unimportant.” |

Roles should be versioned and extensible. Avoid deriving them from names, tags alone, or a single mutually exclusive classifier. Static capability labels and build-local role labels have different sources, scopes, and lifetimes.

## 3. Skill Viability and Investment

### Do not use “viability” as an unqualified score

“Viable” can mean mechanically permitted, configured, activated, effective, or strategically valuable. Those are different assertions and need different evidence. Recommended reporting dimensions:

1. **Eligibility:** mechanics/requirements and build context permit the skill to operate.
2. **Configuration:** the skill is enabled, in the active skill set, and has its relevant socket/equipment/weapon-set context.
3. **Structural engagement:** it participates in validated relationships, trigger paths, contributor paths, or other explicitly modeled mechanics.
4. **Outcome evidence:** a specified outcome is observed or calculated by an authoritative model for this build and condition.
5. **Unknowns:** missing mechanics, unsupported expressions, unmodeled conditions, or absent outcome data.

These dimensions should be reported independently. A configured skill can lack structural evidence; a structurally engaged skill can have no measured outcome. “No evidence yet” must not be rendered as “not viable.”

### Investment evidence

Record exact, interpretable facts without turning them directly into importance:

- Enabled state and active skill-set membership.
- Skill instance and socket-group commitment; count enabled occupants separately from supports.
- Exact direct support count and the identities of unique supports; distinguish repeated supports from unique support choices.
- Validated incoming/outgoing relationship counts by type.
- Direct and indirect contributor paths, preserving path edges and unresolved propagation state.
- Participation in a chain, including whether it is a source candidate, trigger, support, or contributor member.
- Primary-skill selection and `include_in_full_dps` state as separate PoB build-context facts.
- Weapon-set association, equipment grant, persistence/reservation, and explicit resource/mechanic dependencies only when those facts are available.

Support count is a feature of investment, not a rank. It can reflect a chosen link configuration, compatibility, or an experimental setup; it does not alone prove effectiveness, centrality, or primary status. Likewise, contributor count depends on which relationship classes are currently modeled and cannot be treated as a complete measure of importance.

### Importance

Model importance separately from capability and damage. Start with evidence facets rather than an aggregate score:

- **Explicit priority:** primary selection, full-DPS inclusion, or a user-declared build goal.
- **Structural centrality:** validated trigger/dependency/enablement paths and unique downstream roles. A path is structural, not automatically causal.
- **Investment:** configured support and socket/equipment commitment.
- **Operational dependency:** evidence that another selected role cannot operate without this skill or its mechanic.
- **Outcome relevance:** validated effect on a defined build outcome, when a future outcome model exists.

Importance conclusions should state which facet and scope they mean. High structural centrality does not imply high DPS; many supports do not prove importance; no supports do not imply unimportance. Do not produce a single global importance number until its semantics and calibration target are agreed.

## 4. Real-Build Outliers

These are evidence reviews, not new classifications. “Possible role” is explicitly a hypothesis where noted.

| Skill/build | Observed evidence | Role/importance interpretation and unresolved boundary |
|---|---|---|
| **Quarterstaff Strike — Spin to Win Monk** | Exact mechanics record has `Attack`, `MeleeSingleTarget`, `Melee`, and related action types. The Phase 4D validation report shows one direct `Rapid Attacks I SUPPORTS Quarterstaff Strike` edge in the same active socket group. | The instance has an attack capability and a small visible support investment. “Equipment granted” is plausible per the task framing but not currently evidenced in the inspected `SkillRecord`. Do not call it useless or primary/secondary damage from those facts alone. Another build may select and invest in it as its primary skill. |
| **Hollow Form — Spin to Win Monk** | The mechanics record identifies `Meta`, `Attack`, `ConsumesCharges`, `SkillConsumesPowerChargesOnUse`, `Channel`, `Melee`, and `Sustained`. The validation output includes two separate `Hollow Form` instances: one with no direct supports and another with Close Combat II, Brutality III, and Blindside. | The different instance-level investments show why names cannot be aggregated as one role. Candidate roles include meta/attack and charge consumer; whether one instance is active, central, or damage-relevant requires its group and operating conditions. |
| **Charge Regulation — Spin to Win Monk** | The mechanics record declares `OngoingSkill`, `HasReservation`, `Buff`, and `Persistent`. The validation report records Uhtred's Exodus supporting the skill in one observed configuration. The record does not, in the cited fields, explicitly declare charge generation or consumption. | Persistent buff/provider is a supported capability description. “Resource generator” or “high importance” remains unresolved without explicit resource mechanics or dependency evidence. Do not infer charge behavior from the skill's name. |
| **Herald of Ice — Spin to Win Monk and Whirling Twisters** | Mechanics types include `Buff`, `HasReservation`, `Area`, `Cold`, `Herald`, `OngoingSkill`, `Persistent`, and `Attack`; the reviewed record does not declare `Damage`/`DamageOverTime`. The validation report records two direct support edges in Spin to Win and five in Whirling Twisters. | Many support edges are clear configuration/compatibility investment, but they do not prove damage or effects. Possible Herald/buff provider or damage-interaction role remains unproven by the path evidence. `Attack` alone should not certify a damage source. |
| **Herald of Thunder — Spin to Win Monk** | Mechanics include `Buff`, `Herald`, `Attack`, and persistence/reservation types; two exact direct supports are reported. No `Damage`/`DamageOverTime` declaration is shown in the reviewed record. | The build has explicit socket investment. Damage capability in actual Herald interactions and the skill's importance remain unresolved; avoid both “damage source” and “irrelevant” conclusions based only on current fields. |
| **Cast on Critical — Whirling Twisters** | Mechanics declare `Meta`, `Buff`, `GeneratesEnergy`, and `Triggers`. Boundless Energy II directly supports it; validated trigger edges target Profane Ritual, Elemental Weakness, Frost Bomb, and Flame Wall in the same socket group. | Strong structural evidence for trigger-provider and energy-related capability, with one support. Its centrality to these four trigger paths is distinct from direct damage. The contribution of the support through triggered skills remains unresolved. |
| **Companion: Frozen Mandibles — Whirling Twisters** | Mechanics include `Minion`, `Companion`, `CreatesMinion`, and `CreatesCompanion` (among other types). Brutus' Brain directly supports it in socket group 8. | Evidence supports a companion/minion creation capability and configured support. It does not establish companion ownership after activation, attack behavior, damage, or build importance. |
| **Herald of Ash — Gemling Firesmasher** | The current Phase 4D validation report records four direct support relations. The mechanics record shown in the Phase 4D.1 report declares `Buff`, `Herald`, `CausesBurning`, `Area`, and `DamageOverTime`. | Damage-related capability is explicitly declared, alongside buff/Herald capability, but the build role and realized contribution remain undetermined. Four supports evidence investment, not a primary damage role. The reviewed type list does **not** itself establish “explosion mechanics”; require an explicit mechanics/effect record before recording that claim. |
| **Walking Calamity — Gemling Firesmasher** | The Phase 4D validation report records five direct support relations. The reviewed source-role notes identify it as an Attack-only candidate without a declared `Damage`/`DamageOverTime` type. | Five supports are substantial socket investment evidence, but not proof of primary/secondary damage or realized impact. A role assessment requires broader mechanics evidence and explicit conditions, not the support count. |

### Report inconsistency to preserve for follow-up

The Phase 4D.2 manual-review text says Herald of Ash lacks `Damage`/`DamageOverTime`, while the Phase 4D.1 mechanics evidence for `HeraldOfAshPlayer` in `act_str.lua` explicitly lists `DamageOverTime` and `CausesBurning`. The foundation and validation reports also differ in the listed direct support edges for this skill. These are source-evidence discrepancies, not a basis for silently changing either existing report in this design-only phase. Before using old classification or support counts as validation truth, reconcile them against the authoritative mechanics record and accepted relationship output for the same build snapshot, and record the source fingerprints.

## 5. Future-Proofing and Leveling Builds

### Avoiding hard-coded assumptions

- Key build facts by build-local skill-instance identity plus authoritative mechanics identity/version—not display name.
- Keep static capability facts separate from role assignments that depend on skill group, trigger edges, weapon set, equipment, conditions, or player goals.
- Allow multiple role assignments, role hypotheses, unknowns, and later revisions without mutating the underlying source evidence.
- Never encode “Quarterstaff Strike is utility,” “Herald means damage,” or similar name/archetype rules. A future build can make the same skill primary by changing selection, socket investment, relationships, or explicit mechanics context.
- Store derivation rule IDs and versions so new game data or rules can yield a new conclusion while preserving the original observations.

### Leveling and transitional builds

Low-level builds may have few supports, temporary utility skills, incomplete requirements, weaponless configurations, and rapidly changing roles. Therefore:

- Interpret investment and readiness relative to a build stage (character/gem level, target progression point, available equipment, weapon set, and active configuration).
- Record `not yet available`, `not configured`, `temporarily configured`, and `unknown` distinctly where authoritative evidence supports those states.
- Treat absence of supports or a current damage-chain edge as “no such evidence in this snapshot,” not as low viability.
- Do not compare a leveling setup to an endgame build using unnormalized support/socket counts.
- The inspected `SkillRecord` does not carry gem level or a progression timeline; leveling viability will need explicit stage/context inputs before it can be evaluated consistently.

## 6. Recommended Shared Evidence Schema

All future build-understanding systems should consume a common evidence contract. It should standardize provenance and reference semantics, not force every subsystem to share one inference rule.

### Evidence record

```text
EvidenceRecord
  evidence_version             # schema contract version
  evidence_id                  # immutable record ID
  build_id                     # analyzed build snapshot ID
  skill_id                     # build-local skill-instance ID, or null
  skill_name                   # snapshot display name, or null
  socket_group                 # group/slot context, or null
  subject_ref                  # build, skill instance, relationship, path, outcome
  category                     # capability, mechanics, relationship, contributor,
                               # investment, build_context, or outcome
  type                         # factual predicate from a controlled vocabulary
  value                        # typed value; preserve original/raw value as needed
  source_system                # authority or subsystem that supplied the fact
  strength                     # evidence basis, not probability or contribution
  evidence_path[]              # ordered, inspectable provenance steps
  timestamp                    # record creation time
  provenance:
    source_version / fingerprint
    source_locator             # file, line/field, XML group, or rule/result ID
    processor                  # parser/validator/model name and version
  scope:
    related entities/endpoints
    active skill set / socket group / weapon set
    applicability conditions
  evidence_state               # observed, validated, derived, unsupported, ambiguous, etc.
  lineage[]                    # parent evidence IDs and relationship to this record
  limitations[]                # what the evidence explicitly does not establish
  notes[]                      # optional explanatory context; not proof
```

`EvidenceRecord` stores facts or reproducible derived facts. It must not embed a role, importance, viability, or damage-source conclusion as though that conclusion were raw evidence.

### Formal JSON Schema

The following JSON Schema is the proposed normative wire contract for evidence records. It refines the earlier 1.0.0 draft with the explicit build/skill context, strength, path, timestamp, and lineage fields requested for Phase 4D.3. Since the earlier schema is design-only and has not been implemented or persisted, this proposal uses `evidence_version` 2.0.0 as the first complete contract rather than requiring a migration from deployed data. A single schema applies across mechanics, relationships, contributors, damage chains, skill roles, viability assessment, and future optimizer inputs. Subsystems may define controlled predicate vocabularies and typed `value` payloads, but must not emit a record that fails this contract.

```json
{
  "$schema": "https://json-schema.org/draft/2020-12/schema",
  "$id": "https://poe2buildoptimizer.local/schemas/evidence-record-2.0.0.schema.json",
  "title": "PoE2 Build Optimizer Evidence Record",
  "description": "Immutable, provenance-bearing fact or derived fact. Conclusions belong in separate conclusion records.",
  "type": "object",
  "additionalProperties": false,
  "required": [
    "evidence_version",
    "evidence_id",
    "build_id",
    "skill_id",
    "skill_name",
    "socket_group",
    "subject_ref",
    "category",
    "type",
    "value",
    "source_system",
    "strength",
    "evidence_path",
    "timestamp",
    "vocabulary_version",
    "provenance",
    "scope",
    "evidence_state",
    "lineage",
    "limitations",
    "notes"
  ],
  "properties": {
    "evidence_version": {
      "const": "2.0.0"
    },
    "evidence_id": {
      "type": "string",
      "minLength": 1,
      "description": "Stable identifier for this immutable record."
    },
    "build_id": {
      "type": "string",
      "minLength": 1,
      "description": "Stable identifier for the analyzed build snapshot; distinct from the source file path."
    },
    "skill_id": {
      "type": ["string", "null"],
      "minLength": 1,
      "description": "Build-local skill-instance ID, not a gem/game/mechanics ID. Null only for build-level evidence with no skill subject or when skill identity is unresolved."
    },
    "skill_name": {
      "type": ["string", "null"],
      "minLength": 1,
      "description": "Display name captured from the build snapshot; not an identity key. Null only when there is no skill subject or no name could be resolved."
    },
    "socket_group": {
      "type": ["string", "null"],
      "description": "Build-local socket group/slot identifier, or null when the evidence is not group-scoped or the group is unknown."
    },
    "subject_ref": {
      "anyOf": [
        { "$ref": "#/$defs/entityRef" },
        { "type": "null" }
      ]
    },
    "category": {
      "enum": [
        "capability",
        "mechanics",
        "relationship",
        "contributor",
        "investment",
        "build_context",
        "outcome"
      ]
    },
    "type": {
      "type": "string",
      "minLength": 1,
      "description": "Controlled factual predicate within category; must not encode a derived role, importance, viability, or optimizer recommendation."
    },
    "value": {
      "description": "Typed factual payload. Predicate registries define predicate-specific constraints.",
      "oneOf": [
        { "type": "null" },
        { "type": "boolean" },
        { "type": "number" },
        { "type": "string" },
        { "type": "array" },
        { "type": "object" }
      ]
    },
    "source_system": {
      "type": "string",
      "minLength": 1,
      "description": "Originating authority or subsystem (for example pob_mechanics, build_xml, relationship_validator, contributor_discovery, or outcome_model)."
    },
    "strength": {
      "enum": [
        "authoritative",
        "validated",
        "observed",
        "derived",
        "limited",
        "unknown"
      ],
      "description": "Evidence basis, not a probability or contribution magnitude."
    },
    "evidence_path": {
      "type": "array",
      "minItems": 1,
      "items": {
        "$ref": "#/$defs/evidencePathStep"
      },
      "description": "Non-empty, ordered provenance trail from the source fact to this record; source_locator remains the canonical compact locator."
    },
    "timestamp": {
      "type": "string",
      "format": "date-time",
      "description": "UTC time this immutable record was created (normalized ISO 8601 ending in Z); not necessarily the time the game/build event occurred."
    },
    "vocabulary_version": {
      "type": "string",
      "minLength": 1,
      "description": "Version of the controlled category/type vocabulary used to interpret this record."
    },
    "provenance": {
      "type": "object",
      "additionalProperties": false,
      "required": [
        "source_locator",
        "processor"
      ],
      "properties": {
        "source_version": {
          "type": ["string", "null"]
        },
        "source_fingerprint": {
          "type": ["string", "null"]
        },
        "source_locator": {
          "type": "string",
          "minLength": 1,
          "description": "File/line, build XML field/group, accepted relationship ID, or other reproducible source location."
        },
        "processor": {
          "type": "object",
          "additionalProperties": false,
          "required": ["name", "version"],
          "properties": {
            "name": {
              "type": "string",
              "minLength": 1
            },
            "version": {
              "type": "string",
              "minLength": 1
            }
          }
        }
      },
      "anyOf": [
        {
          "required": ["source_version"],
          "properties": {
            "source_version": {
              "type": "string",
              "minLength": 1
            }
          }
        },
        {
          "required": ["source_fingerprint"],
          "properties": {
            "source_fingerprint": {
              "type": "string",
              "minLength": 1
            }
          }
        }
      ]
    },
    "scope": {
      "type": "object",
      "additionalProperties": false,
      "required": ["entities", "conditions"],
      "properties": {
        "entities": {
          "type": "array",
          "items": {
            "$ref": "#/$defs/entityRef"
          },
          "uniqueItems": true
        },
        "active_skill_set": {
          "type": ["string", "null"]
        },
        "weapon_set": {
          "type": ["integer", "null"]
        },
        "conditions": {
          "type": "array",
          "items": {
            "type": "string",
            "minLength": 1
          },
          "uniqueItems": true
        }
      }
    },
    "evidence_state": {
      "enum": [
        "observed",
        "validated",
        "derived",
        "unsupported",
        "ambiguous",
        "not_declared",
        "not_observed",
        "not_applicable",
        "unknown"
      ]
    },
    "lineage": {
      "type": "array",
      "items": {
        "$ref": "#/$defs/lineageRef"
      },
      "uniqueItems": true,
      "description": "References evidence records used to derive this record. Empty for directly observed evidence; non-empty for derived evidence."
    },
    "limitations": {
      "type": "array",
      "items": {
        "type": "string",
        "minLength": 1
      },
      "uniqueItems": true
    },
    "notes": {
      "type": "array",
      "items": {
        "type": "string"
      },
      "description": "Optional human-readable context; never authoritative evidence or a substitute for provenance."
    },
    "observed_at": {
      "type": ["string", "null"],
      "format": "date-time",
      "description": "Optional time the underlying fact was observed, if distinct from record creation time; normalize to UTC."
    }
  },
  "$defs": {
    "entityRef": {
      "type": "object",
      "additionalProperties": false,
      "required": ["kind", "id"],
      "properties": {
        "kind": {
          "enum": [
            "build",
            "skill_instance",
            "mechanics_record",
            "relationship",
            "contributor_path",
            "damage_chain",
            "equipment",
            "outcome"
          ]
        },
        "id": {
          "type": "string",
          "minLength": 1
        }
      }
    },
    "evidencePathStep": {
      "type": "object",
      "additionalProperties": false,
      "required": ["source_system", "locator"],
      "properties": {
        "source_system": {
          "type": "string",
          "minLength": 1
        },
        "locator": {
          "type": "string",
          "minLength": 1
        },
        "reference_id": {
          "type": ["string", "null"]
        }
      }
    },
    "lineageRef": {
      "type": "object",
      "additionalProperties": false,
      "required": ["evidence_id", "relation"],
      "properties": {
        "evidence_id": {
          "type": "string",
          "minLength": 1
        },
        "relation": {
          "enum": ["derived_from", "validated_by", "corroborated_by", "contradicted_by"]
        }
      }
    }
  },
  "allOf": [
    {
      "if": {
        "properties": {
          "evidence_state": {
            "const": "derived"
          }
        },
        "required": ["evidence_state"]
      },
      "then": {
        "properties": {
          "lineage": {
            "minItems": 1
          }
        }
      }
    },
    {
      "if": {
        "properties": {
          "evidence_state": {
            "const": "observed"
          }
        },
        "required": ["evidence_state"]
      },
      "then": {
        "properties": {
          "lineage": {
            "maxItems": 0
          }
        }
      }
    }
  ]
}
```

The schema validates record shape, types, required provenance, scope, and derived-evidence lineage. Predicate registries and semantic validation must additionally enforce predicate-specific value types, category/predicate compatibility, valid referenced build entities, valid lineage references, agreement between the redundant skill context and `subject_ref`/scope, and the rule that evidence predicates describe facts rather than conclusions. The JSON Schema `format` keyword may be annotation-only in a validator configuration, so the implementation must explicitly enable or separately validate ISO date-time and UTC normalization. Schema conformance is necessary, not sufficient, for evidential validity.

### Evidence Record Field Review

The user-proposed fields are retained as a stable, flat reporting envelope while typed references and provenance remain available for machine validation. The schema requires the keys to be present; fields marked nullable use explicit `null` when not applicable or unresolved rather than omitting the field.

| Field | Required? | Refined meaning and validation |
|---|---|---|
| `evidence_version` | Yes | Schema-contract version (`2.0.0` in this proposal); not the game or PoB version. |
| `evidence_id` | Yes | Unique immutable record identifier, stable across reads and references. |
| `build_id` | Yes | Identifier for the analyzed build snapshot; must distinguish different snapshots of one build. |
| `skill_id` | Yes, nullable | Stable build-local skill-instance ID, not gem/game/granted-effect ID. Null for build-level evidence or when no skill subject can be resolved. |
| `skill_name` | Yes, nullable | Display label captured from the same snapshot; null if unavailable. Never use it as an identity key. |
| `socket_group` | Yes, nullable | Exact group/slot context where applicable; null when not group-scoped or unavailable. |
| `category` | Yes | Controlled high-level evidence category. Use `relationship`, for example, for a validated edge; do not encode a conclusion category here. |
| `type` | Yes | Controlled factual predicate such as `skill_type_declared`, `relationship_accepted`, or `support_count_observed`. It is not a role label. |
| `value` | Yes | Predicate-specific typed JSON value. Null is permitted only where the predicate/state definition allows it. |
| `source_system` | Yes | Originating authority/subsystem (`pob_mechanics`, `build_xml`, `relationship_validator`, and so on); distinguish from the processor that parsed it. |
| `strength` | Yes | Qualitative evidence basis (`authoritative`, `validated`, `observed`, `derived`, `limited`, `unknown`); not a probability, impact, or DPS score. |
| `evidence_path` | Yes, non-empty | Ordered provenance steps from the source fact to this record. `source_locator` is the canonical compact locator; the path shows the trace. |
| `timestamp` | Yes | UTC record creation time. Optional `observed_at` records source/event time where different; timestamp alone must not imply game-state recency. |
| `lineage` | Yes, may be empty | Empty for directly observed evidence; derived evidence requires at least one parent record with a `derived_from` relation. Validators/semantic checks verify parent existence and acyclicity. |
| `notes` | Yes, may be empty | Human-readable caveats or explanation only. Notes are not evidence and cannot satisfy provenance or lineage requirements. |
| `subject_ref` | Yes, nullable | Typed reference to the principal build/skill/relationship/path/outcome subject. Must agree with `build_id`, `skill_id`, and scope where those fields overlap. |
| `provenance` | Yes | Contains canonical source locator, source version or fingerprint, and processor name/version. |
| `scope` | Yes | Related entities and applicability conditions; includes active skill-set and weapon-set context when known. |
| `evidence_state` | Yes | Distinguishes observed, validated, derived, unsupported, ambiguous, not-declared, not-observed, not-applicable, and unknown. |
| `limitations` | Yes, may be empty | Explicit boundaries of what the fact does not establish. Prefer specific limitations for compatibility, trigger activation, and effect propagation evidence. |
| `vocabulary_version` | Yes | Version of the controlled `category`/`type` vocabulary. Prevents interpreting the same token differently after vocabulary changes. |
| `observed_at` | No | Optional event/source observation time, ISO date-time or null. |

This is intentionally stricter than a generic event log. Build and skill fields are present on every record for a uniform consumer contract; skill fields can be null for build-level evidence or unresolved identity. For all skill-scoped evidence, semantic validation requires a resolvable build-local instance ID or an explicit unresolved state, and checks that the display name/group match that build snapshot. Relationships and paths include all endpoints in `scope.entities`, not just the anchor skill.

`strength` describes the source/basis of a fact; `evidence_state` describes its resolution/validation status. They are orthogonal: for example, authoritative PoB data may be `strength: authoritative` and `evidence_state: ambiguous` if identity resolution finds duplicate records. Do not order these strengths numerically or compare them as probabilities.

Recommended factual `type` examples:

- `skill_type_declared` with the exact PoB type token (capability evidence).
- `mechanics_field_declared` with the field/value and source location (mechanics evidence).
- `relationship_accepted` with relationship type and exact source/target references (relationship evidence).
- `contributor_path_validated` with ordered edge evidence IDs and path length (contributor evidence; not proof of propagation).
- `support_count_observed` with count and the exact support instance IDs used to compute it (investment evidence).
- `primary_skill_selected`, `skill_enabled`, or `equipment_grant_observed` only when the build source explicitly supports the fact (build-context evidence).
- `outcome_measured` or `outcome_calculated` with units, conditions, model/source and version (outcome evidence).

“Can damage,” “high importance,” “viable,” and “primary damage source” are not raw evidence `type` values. They are conclusions in a separate record that references the underlying Evidence Records and a versioned derivation rule. For example, `Attack` alone can be recorded as `skill_type_declared`; it cannot be relabeled `can_damage` absent an explicit source fact or a documented derived rule with parent lineage.

### JSON Schema Validation and Compatibility

- **Schema version policy:** Draft 2020-12 remains the JSON Schema dialect. `evidence_version` versions the record contract independently of the JSON Schema dialect, PoB data, and `vocabulary_version`. The earlier 1.0.0 text was an unimplemented design draft; 2.0.0 is the proposed first complete contract, not a claim that deployed records need migration.
- **Breaking changes:** removing/renaming a required field, narrowing a type, changing field meaning, or changing lineage semantics requires a new major `evidence_version` and a new immutable schema `$id`.
- **Compatible changes:** an additive optional field or new vocabulary token may use a minor version only if strict old consumers can safely reject it or a compatibility policy explicitly permits it. Because this schema uses `additionalProperties: false`, adding a field is not automatically backward-compatible; producers and consumers must negotiate schema support.
- **Patch changes:** clarifications, examples, or corrections that do not change validation or semantics may be documented as patch-level changes. Never change an old schema's meaning in place.
- **Old records:** consumers must validate against the record's declared `evidence_version`. An unknown version is rejected or quarantined with a visible diagnostic; consumers must not guess, coerce, or silently drop fields.
- **Migration:** if a later implementation discovers persisted records from an older schema, use an explicit, versioned adapter that preserves the original bytes/record and emits a new immutable record with migration provenance. Missing `build_id`, identity, source path, strength, or timestamp must remain unknown/unavailable; migration must not fabricate them. No such migration is required for the current design-only 1.0.0 draft.
- **Validation layers:** JSON Schema validates structural shape and basic constraints. Semantic validators must also verify source/processor provenance, existence and same-build scope of referenced entities, uniqueness and acyclicity of lineage, a `derived_from` parent for derived records, predicate/category/value compatibility, skill context consistency, evidence-path resolution, UTC timestamp normalization, and allowed state/strength combinations.
- **Producer and consumer gates:** every producer validates before storing or publishing. Every consumer rejects or quarantines invalid/unsupported evidence versions before deriving conclusions. Reports must expose validation failures; there is no success-shaped fallback.
- **Immutability:** schema validity alone cannot enforce storage immutability. The persistence/API contract must reject updates to accepted evidence and support append-only corrections; conclusions may be recomputed without modifying their source records.

### Immutability and evolution contract

- **Evidence is immutable.** Once an evidence record is accepted and referenced, its predicate, value, provenance, scope, state, lineage, and limitations must not be edited in place. Storage should be append-only; the schema does not permit update operations.
- **Corrections create new evidence.** A corrected parser, source snapshot, identity resolution, or validation result creates a new record with a new `evidence_id` and provenance. A supersession link may be added in a future schema revision; it must not erase or rewrite the earlier observation.
- **Conclusions are derived separately.** Role, importance, viability, source classification, damage-chain classification, and optimizer recommendations reference evidence IDs and a versioned rule. When rules change, recompute conclusions while retaining the same immutable evidence records where their source facts remain valid.
- **Every subsystem validates at its boundary.** Evidence producers must validate before publishing or persisting records. Consumers must reject or explicitly quarantine non-conforming records rather than silently normalizing, dropping, or treating them as valid.
- **Versioning is explicit.** `evidence_version` identifies the record contract; `source_version`/`source_fingerprint` identifies source data; `processor` identifies the parser/validator/model that produced the record. A future incompatible schema change requires a new schema version and an explicit migration, not reinterpretation of old evidence.
- **Raw facts remain inspectable.** Derived evidence references its parents. Validators preserve exact endpoint, relationship type, source locator, and conditions needed to reproduce accepted relationship or contributor-path evidence.

The formal schema does not itself make evidence immutable or prove a record's truth. The append-only persistence/API contract enforces immutability; semantic validators establish that the record is supported by its cited source and not merely well-shaped JSON.

### Evidence categories

| Category | Example records | Important limitation |
|---|---|---|
| **Capability** | Mechanics declares `Attack`, `Herald`, `DamageOverTime`, `Triggers`, `CreatesCompanion`. | A declaration proves the declared capability/type, not its use or result in this build. |
| **Mechanics** | Explicit charge generation/consumption, burning, explosion, resource requirement, ownership, condition, or unsupported source expression. | Preserve the exact declared field/expression and parser support state. Do not invent a semantic interpretation for unsupported Lua. |
| **Relationship** | Validator-accepted `SUPPORTS`/`TRIGGERS` with exact endpoints, type, group, rule and evidence. | Compatibility/activation relationship is not effect propagation. |
| **Contributor** | Direct/indirect path, ordered edge references, topology, Structural/Unresolved classification. | A structural path does not prove causal contribution or propagation. |
| **Investment** | Enabled group occupants; exact support identities/count; primary and full-DPS flags; configured skill-set/weapon-set membership. | Configuration and commitment do not prove importance or outcome. |
| **Build context** | Primary selection, persistent/reservation state, explicit equipment-grant link, triggered status, active group, user goal, build stage. | Store observed context distinctly from inferred context. Unknown source provenance remains unknown. |
| **Outcome** | A measured or calculated damage/resource/defence result tied to a build snapshot and conditions. | Requires its own validated model/source, units, assumptions, and scope; it is not implied by the other categories. |

### Missingness and conclusions

Never collapse these states into one false/empty value:

- **Not declared:** the parsed authoritative record does not contain that field.
- **Not parsed / unsupported:** the source may contain semantics the current parser cannot safely interpret.
- **Ambiguous:** multiple identity/mechanics matches or conflicting evidence exist.
- **Not observed in this build snapshot:** no relevant build-local fact was found.
- **Not applicable:** the evidence type does not apply under known conditions.
- **Unknown:** available evidence cannot settle the question.

Store conclusions separately:

```text
BuildUnderstandingConclusion
  conclusion_id
  subject_ref
  dimension                   # role, importance facet, readiness, source status, etc.
  label / state
  supporting_evidence_ids[]
  contradicting_evidence_ids[]
  derivation_rule_id + version
  scope / conditions
  unresolved_questions[]
```

This supports the required distinction:

```text
Evidence: A particular validated report lists four direct SUPPORTS edges to Herald of Ash (with another report listing fewer).
Conclusion: The reports disagree about the observed investment; the accepted edge evidence must be reconciled for one build snapshot.
Not concluded: It is the primary damage source or its damage is important.
```

Every consumer—including future optimizer logic—must be able to show which evidence records and rule version produced its conclusion. Optimizer scores and recommendations must retain their own evidence references and must not overwrite the underlying facts.

## 7. Capability, Role, Importance, and Viability Model

Recommended conceptual outputs:

```text
SkillUnderstanding
  skill_instance_ref
  capability_evidence[]
  build_role_assignments[]       # multi-label and scoped
  investment_evidence[]
  importance_facets[]            # no mandatory aggregate score
  readiness_dimensions[]        # eligibility/configuration/engagement/outcome
  unresolved_questions[]
```

The model deliberately has no required `is_damage` Boolean and no required numeric viability/importance score. A later consumer may derive a bounded, purpose-specific summary from evidence, but must identify its target question, conditions, rule, and limitations.

## 8. Information Required by Future Consumers

- **Damage Source Classification:** declared damage-related capability and exact build-instance context, explicit candidate/unknown state, any role and investment evidence, limitations, and provenance. `Attack` alone must remain insufficient proof of damage.
- **Damage Chain Integration:** source candidates, trigger/support/contributor edges and paths with evidence IDs, topology, build scope, conditions, and unresolved propagation boundaries. A chain classification must reference—not replace—the evidence records that justified its members and type.
- **Damage Chain Classification:** candidate source capability, exact instance role evidence, trigger/support topology, uncertainty state, and role/source evidence provenance. Do not feed chain type back as independent proof of damage.
- **DamageChainResolver replacement:** all selected and non-selected skill instances, multi-role assignments, explicit primary/full-DPS context, trigger paths, socket/weapon/equipment scope, and diagnostics for unresolved mechanics. Preserve multiple candidates.
- **Future Optimizer:** build goal and stage, configured role evidence, explicit constraints, readiness/eligibility, outcome evidence if available, and traceable reasons for each score or recommendation. Any score/recommendation remains a replaceable conclusion over immutable evidence. No optimizer logic is designed here.
- **Build Analysis Reports:** facts and conclusions in separate sections; list direct evidence, missing/unsupported evidence, conditions, and why a role or viability assessment remains unresolved.

## 9. Risks and Guardrails

1. **Capability overreach:** `Attack`, `Herald`, `Minion`, or `Companion` may be misread as proof of damage. Report capability verbatim and keep source classification separate.
2. **Investment-to-importance leap:** support and contributor counts are configuration/topology metrics with incomplete coverage; never treat them as impact scores by default.
3. **Name-level aggregation:** duplicate instances such as Hollow Form can have different groups and support configurations. Evaluate instances before any carefully defined skill-definition aggregation.
4. **False negatives from incomplete mechanics parsing:** missing fields, dynamic Lua, or unsupported expressions must create diagnostics/unknowns, not negative facts.
5. **Transitive propagation assumptions:** a support→trigger→target path remains structural unless explicit effect-transfer evidence exists.
6. **Primary selection overreach:** PoB's primary selection is useful context, not universal proof of actual damage or strategic centrality.
7. **Build-stage mismatch:** raw counts across leveling/endgame snapshots are not comparable without stage and configuration context.
8. **Evidence drift:** installed PoB data, parser behavior, and validation rules can change. Persist source fingerprint, source/version, and derivation rule version.
9. **Report inconsistency:** reconcile the Herald of Ash discrepancy above before treating prior manual-review labels as ground truth.

## 10. Validation Strategy

Use an evidence-first validation sequence:

1. **JSON Schema conformance:** positive/negative fixtures validate required fields, enums, types, closed objects, source-version/fingerprint presence, scope, and references. Every subsystem producer is tested to reject a malformed record before publish/persist.
2. **Lineage and semantic validation:** derived records require existing parent IDs and a `derived_from` lineage relation; directly observed records cannot claim parents under schema 2.0.0. Predicate-specific validators check category/value compatibility, source support, referenced entity existence, and that facts are not conclusion labels.
3. **Immutability tests:** after acceptance, updates to evidence are rejected. Parser/source corrections append new evidence IDs, and existing conclusions continue to resolve their original evidence. Rule-version changes recompute conclusions without mutating evidence.
4. **Conclusion references:** every conclusion has one or more existing evidence references and a versioned derivation rule; unsupported/unknown states survive serialization and reporting.
5. **Instance-scope tests:** multiple instances with the same display name retain distinct role/investment evidence, including separate Hollow Form groups.
6. **Capability boundary tests:** `Attack` alone does not prove damage; explicit `DamageOverTime` is retained as declared capability without automatically choosing a build role.
7. **Relationship boundary tests:** accepted support/trigger edges retain exact endpoints and do not prove effect propagation.
8. **Investment boundary tests:** support counts and socket commitment report as facts but do not automatically raise primary status, importance, or viability.
9. **Role multiplicity tests:** a skill can simultaneously hold supported, separate role hypotheses with scope and evidence.
10. **Unknown/unsupported tests:** absent, ambiguous, unsupported, not-observed, and not-applicable evidence remain distinguishable.
11. **Build fixtures:** validate Spin to Win Monk, Whirling Twisters, Gemling Firesmasher, a low-level/leveling build, a weaponless/transitional Monk, and a future archetype where Quarterstaff Strike is primary.
12. **Human review:** inspect every role and importance facet against exact build instances, support groups, validated relationship paths, authoritative mechanics, and conditions. Record disagreements; do not silently convert reviewer interpretation into evidence.
13. **Regression boundary:** no changes to Relationship Discovery or existing validation reports as part of this design. Any future implementation is a separately approved phase with unchanged upstream evidence unless explicitly in scope.

## 11. Recommended Roadmap Changes

1. **Phase 4D.3 — Skill Role & Viability Design:** complete this design investigation; approve terminology, the evidence record fields, and schema evolution rules.
2. **Phase 4D.4 — Shared Evidence Schema Contract:** implement and test the Draft 2020-12 schema profile, vocabulary versioning, semantic validation, append-only evidence storage, and reject/quarantine behavior across build-understanding systems.
3. **Phase 4D.5 — Skill Capability and Build-Context Evidence:** expose authoritative capability facts and build-local configuration facts without assigning semantic roles.
4. **Phase 4D.6 — Multi-role Assessment Foundation:** assign evidence-backed, instance-scoped role candidates and report unresolved/contradictory evidence; no numeric ranking.
5. **Phase 4D.7 — Investment, Importance Facets, and Readiness Reporting:** validate stage-aware evidence summaries on known and random builds; do not introduce an aggregate viability score without a separate design.
6. **Phase 4D.8 — Damage Source Classification Integration:** revisit `Attack`-only candidates and Herald/Minion/Companion cases using the approved schema; only then plan chain classification or resolver replacement.
7. **Optimizer integration:** consume evidence-linked outputs only after the preceding validation and after optimizer requirements define its target outcomes and user goals.

No code or existing report changes are authorized by this investigation. Proceed to implementation only after the evidence contract and role/viability vocabulary are reviewed.
