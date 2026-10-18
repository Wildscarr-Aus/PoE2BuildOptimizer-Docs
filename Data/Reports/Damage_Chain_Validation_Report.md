# Damage Chain Validation Report

**Validation date:** 2026-10-18
**Build directory:** `C:\Users\teamp\OneDrive\Documents\Path of Building (PoE2)\Builds`
**Random selection:** Uniform `secrets.choice` from 21 parseable non-benchmark builds with enabled skills; exact-content benchmark copies excluded.
**Selected random build:** `Marauder\gemling firesmasher.xml`

## Summary

| Build | Total chains | Trigger chains | Support chains | Direct contributors | Indirect contributors | Structural contributors | Unresolved contributors | Cycles | Duplicate chains | Invalid endpoints | Out-of-build endpoints | Unsupported assumptions |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| Spin to Win Monk 0.5.5 | 20 | 0 | 14 | 36 | 0 | 36 | 36 | 0 | 0 | 0 | 0 | 0 |
| Whirling twisters | 15 | 4 | 9 | 30 | 4 | 34 | 34 | 0 | 0 | 0 | 0 | 0 |
| gemling firesmasher | 7 | 1 | 6 | 23 | 0 | 23 | 23 | 0 | 0 | 0 | 0 | 0 |

## Validation Method

The report reran the unchanged SkillIdentity -> PoBSkillDatabase -> RelationshipDiscoveryValidator -> ContributorDiscovery -> ContributorClassifier -> DamageChainFoundation pipeline. Each foundation edge was matched by exact source/target skill-instance identity, relationship type, and evidence against both the validator result and contributor graph. Contributor classifications were checked against classifier output; source and member endpoints were checked against active build skills.

- Support chains count chains with a direct validated SUPPORTS edge targeting the chain source; this does not prove a support effect or damage contribution.
- Trigger chains are categorized by chain type. TRIGGERS verifies activation compatibility only.
- Structural and Unresolved classifications are retained. No Proven contributor is accepted without explicit propagation evidence.
- No behavior or implementation files were changed.

## Build Details

### Spin to Win Monk 0.5.5

**Build file:** `Monk\Spin to Win Monk 0.5.5.xml`  
**Identity primary skill:** Whirling Assault  
**Enabled active-set skills:** 55  
**Validated relationship edges:** 40  
**Contributor paths classified:** 40

| Build-level check | Result |
|---|---|
| Sources and members are valid build instances | PASS |
| Relationship evidence is validator-backed | PASS (36 foundation edge occurrences checked) |
| Contributor references resolve to classifications and validated paths | PASS (36 path edges checked) |
| No cycles / duplicate chains | PASS |
| No unsupported assumptions | PASS |
| Proven without propagation evidence | 0 |

--------------------------------------------------

#### Damage Chain 1 - Primary Damage

Source:
    Whirling Assault (`skill-10`) - structural source candidate
Triggered By:
    None
Supported By:
    Close Combat II (`skill-11`)
    Magnified Area II (`skill-12`)
    Brutality III (`skill-13`)
    Blindside (`skill-14`)
Contributors:
    Close Combat II [Direct, Structural, Unresolved]
        Path: Close Combat II -SUPPORTS-> Whirling Assault
    Magnified Area II [Direct, Structural, Unresolved]
        Path: Magnified Area II -SUPPORTS-> Whirling Assault
    Brutality III [Direct, Structural, Unresolved]
        Path: Brutality III -SUPPORTS-> Whirling Assault
    Blindside [Direct, Structural, Unresolved]
        Path: Blindside -SUPPORTS-> Whirling Assault
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 2 - Secondary Damage

Source:
    Quarterstaff Strike (`skill-1`) - structural source candidate
Triggered By:
    None
Supported By:
    Rapid Attacks I (`skill-2`)
Contributors:
    Rapid Attacks I [Direct, Structural, Unresolved]
        Path: Rapid Attacks I -SUPPORTS-> Quarterstaff Strike
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 3 - Secondary Damage

Source:
    Spirit Vessel (`skill-15`) - structural source candidate
Triggered By:
    None
Supported By:
    Romira's Requital (`skill-19`)
    Amanamu's Tithe (`skill-20`)
Contributors:
    Romira's Requital [Direct, Structural, Unresolved]
        Path: Romira's Requital -SUPPORTS-> Spirit Vessel
    Amanamu's Tithe [Direct, Structural, Unresolved]
        Path: Amanamu's Tithe -SUPPORTS-> Spirit Vessel
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 4 - Secondary Damage

Source:
    Oil Barrage (`skill-16`) - structural source candidate
Triggered By:
    None
Supported By:
    Blindside (`skill-17`)
    Close Combat II (`skill-18`)
Contributors:
    Blindside [Direct, Structural, Unresolved]
        Path: Blindside -SUPPORTS-> Oil Barrage
    Close Combat II [Direct, Structural, Unresolved]
        Path: Close Combat II -SUPPORTS-> Oil Barrage
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 5 - Secondary Damage

Source:
    Tempest Bell (`skill-22`) - structural source candidate
Triggered By:
    None
Supported By:
    Heavy Swing (`skill-23`)
    Bleed III (`skill-24`)
    Close Combat II (`skill-25`)
Contributors:
    Heavy Swing [Direct, Structural, Unresolved]
        Path: Heavy Swing -SUPPORTS-> Tempest Bell
    Bleed III [Direct, Structural, Unresolved]
        Path: Bleed III -SUPPORTS-> Tempest Bell
    Close Combat II [Direct, Structural, Unresolved]
        Path: Close Combat II -SUPPORTS-> Tempest Bell
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 6 - Secondary Damage

Source:
    Shattering Palm (`skill-26`) - structural source candidate
Triggered By:
    None
Supported By:
    Practiced Combo (`skill-27`)
    Rapid Attacks II (`skill-28`)
    Rage III (`skill-29`)
    Ancestral Call II (`skill-30`)
Contributors:
    Practiced Combo [Direct, Structural, Unresolved]
        Path: Practiced Combo -SUPPORTS-> Shattering Palm
    Rapid Attacks II [Direct, Structural, Unresolved]
        Path: Rapid Attacks II -SUPPORTS-> Shattering Palm
    Rage III [Direct, Structural, Unresolved]
        Path: Rage III -SUPPORTS-> Shattering Palm
    Ancestral Call II [Direct, Structural, Unresolved]
        Path: Ancestral Call II -SUPPORTS-> Shattering Palm
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 7 - Secondary Damage

Source:
    Hollow Focus (`skill-3`) - structural source candidate
Triggered By:
    None
Supported By:
    Magnified Area II (`skill-4`)
    Armour Break III (`skill-5`)
    Cooldown Recovery II (`skill-6`)
    Uruk's Smelting (`skill-7`)
    Armour Explosion (`skill-8`)
Contributors:
    Magnified Area II [Direct, Structural, Unresolved]
        Path: Magnified Area II -SUPPORTS-> Hollow Focus
    Armour Break III [Direct, Structural, Unresolved]
        Path: Armour Break III -SUPPORTS-> Hollow Focus
    Cooldown Recovery II [Direct, Structural, Unresolved]
        Path: Cooldown Recovery II -SUPPORTS-> Hollow Focus
    Uruk's Smelting [Direct, Structural, Unresolved]
        Path: Uruk's Smelting -SUPPORTS-> Hollow Focus
    Armour Explosion [Direct, Structural, Unresolved]
        Path: Armour Explosion -SUPPORTS-> Hollow Focus
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 8 - Secondary Damage

Source:
    Hand of Chayula (`skill-31`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 9 - Secondary Damage

Source:
    Herald of Ice (`skill-39`) - structural source candidate
Triggered By:
    None
Supported By:
    Cold Attunement (`skill-40`)
    Poison III (`skill-41`)
Contributors:
    Cold Attunement [Direct, Structural, Unresolved]
        Path: Cold Attunement -SUPPORTS-> Herald of Ice
    Poison III [Direct, Structural, Unresolved]
        Path: Poison III -SUPPORTS-> Herald of Ice
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 10 - Secondary Damage

Source:
    Herald of Thunder (`skill-42`) - structural source candidate
Triggered By:
    None
Supported By:
    Blind II (`skill-43`)
    Elemental Armament II (`skill-44`)
Contributors:
    Blind II [Direct, Structural, Unresolved]
        Path: Blind II -SUPPORTS-> Herald of Thunder
    Elemental Armament II [Direct, Structural, Unresolved]
        Path: Elemental Armament II -SUPPORTS-> Herald of Thunder
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 11 - Secondary Damage

Source:
    Pounce (`skill-45`) - structural source candidate
Triggered By:
    None
Supported By:
    Fist of War II (`skill-47`)
    Cooldown Recovery II (`skill-49`)
Contributors:
    Fist of War II [Direct, Structural, Unresolved]
        Path: Fist of War II -SUPPORTS-> Pounce
    Cooldown Recovery II [Direct, Structural, Unresolved]
        Path: Cooldown Recovery II -SUPPORTS-> Pounce
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 12 - Secondary Damage

Source:
    Hollow Focus (`skill-53`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 13 - Secondary Damage

Source:
    Hollow Form (`skill-54`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 14 - Secondary Damage

Source:
    Spirit Vessel (`skill-55`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 15 - Secondary Damage

Source:
    Hollow Form (`skill-9`) - structural source candidate
Triggered By:
    None
Supported By:
    Close Combat II (`skill-11`)
    Brutality III (`skill-13`)
    Blindside (`skill-14`)
Contributors:
    Close Combat II [Direct, Structural, Unresolved]
        Path: Close Combat II -SUPPORTS-> Hollow Form
    Brutality III [Direct, Structural, Unresolved]
        Path: Brutality III -SUPPORTS-> Hollow Form
    Blindside [Direct, Structural, Unresolved]
        Path: Blindside -SUPPORTS-> Hollow Form
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 16 - Utility

Source:
    Charge Regulation (`skill-21`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 17 - Utility

Source:
    Freezing Mark (`skill-32`) - structural source candidate
Triggered By:
    None
Supported By:
    Charged Mark (`skill-34`)
    Mark for Death (`skill-35`)
    Eternal Mark (`skill-36`)
Contributors:
    Charged Mark [Direct, Structural, Unresolved]
        Path: Charged Mark -SUPPORTS-> Freezing Mark
    Mark for Death [Direct, Structural, Unresolved]
        Path: Mark for Death -SUPPORTS-> Freezing Mark
    Eternal Mark [Direct, Structural, Unresolved]
        Path: Eternal Mark -SUPPORTS-> Freezing Mark
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 18 - Utility

Source:
    Elemental Weakness (`skill-33`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 19 - Utility

Source:
    Ghost Dance (`skill-37`) - structural source candidate
Triggered By:
    None
Supported By:
    Cooldown Recovery II (`skill-38`)
Contributors:
    Cooldown Recovery II [Direct, Structural, Unresolved]
        Path: Cooldown Recovery II -SUPPORTS-> Ghost Dance
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 20 - Utility

Source:
    Mana Remnants (`skill-50`) - structural source candidate
Triggered By:
    None
Supported By:
    Remnant Potency III (`skill-51`)
    Harmonic Remnants II (`skill-52`)
Contributors:
    Remnant Potency III [Direct, Structural, Unresolved]
        Path: Remnant Potency III -SUPPORTS-> Mana Remnants
    Harmonic Remnants II [Direct, Structural, Unresolved]
        Path: Harmonic Remnants II -SUPPORTS-> Mana Remnants
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Review Notes

- Spirit Vessel: Minion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Spirit Vessel: Companion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Herald of Ice: Herald effects/downstream interactions need future modeling.
- Herald of Thunder: Herald effects/downstream interactions need future modeling.
- Spirit Vessel: Minion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Spirit Vessel: Companion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Freezing Mark: Mark application, target scope, and interactions need future modeling.
- Romira's Requital SUPPORTS Spirit Vessel: compatibility evidence is valid; no effect/damage propagation is concluded.
- Amanamu's Tithe SUPPORTS Spirit Vessel: compatibility evidence is valid; no effect/damage propagation is concluded.
- Charged Mark SUPPORTS Freezing Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Mark for Death SUPPORTS Freezing Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Eternal Mark SUPPORTS Freezing Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Cold Attunement SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Poison III SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Blind II SUPPORTS Herald of Thunder: compatibility evidence is valid; no effect/damage propagation is concluded.
- Elemental Armament II SUPPORTS Herald of Thunder: compatibility evidence is valid; no effect/damage propagation is concluded.

### Whirling twisters

**Build file:** `Amazon\Whirling twisters.xml`  
**Identity primary skill:** Twister  
**Enabled active-set skills:** 43  
**Validated relationship edges:** 30  
**Contributor paths classified:** 34

| Build-level check | Result |
|---|---|
| Sources and members are valid build instances | PASS |
| Relationship evidence is validator-backed | PASS (34 foundation edge occurrences checked) |
| Contributor references resolve to classifications and validated paths | PASS (38 path edges checked) |
| No cycles / duplicate chains | PASS |
| No unsupported assumptions | PASS |
| Proven without propagation evidence | 0 |

--------------------------------------------------

#### Damage Chain 1 - Primary Damage

Source:
    Twister (`skill-1`) - structural source candidate
Triggered By:
    None
Supported By:
    Projectile Acceleration III (`skill-2`)
    Prolonged Duration II (`skill-3`)
    Salvo (`skill-4`)
    Overextend (`skill-5`)
    Blindside (`skill-6`)
Contributors:
    Projectile Acceleration III [Direct, Structural, Unresolved]
        Path: Projectile Acceleration III -SUPPORTS-> Twister
    Prolonged Duration II [Direct, Structural, Unresolved]
        Path: Prolonged Duration II -SUPPORTS-> Twister
    Salvo [Direct, Structural, Unresolved]
        Path: Salvo -SUPPORTS-> Twister
    Overextend [Direct, Structural, Unresolved]
        Path: Overextend -SUPPORTS-> Twister
    Blindside [Direct, Structural, Unresolved]
        Path: Blindside -SUPPORTS-> Twister
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 2 - Secondary Damage

Source:
    Companion: Frozen Mandibles (`skill-34`) - structural source candidate
Triggered By:
    None
Supported By:
    Brutus' Brain (`skill-35`)
Contributors:
    Brutus' Brain [Direct, Structural, Unresolved]
        Path: Brutus' Brain -SUPPORTS-> Companion: Frozen Mandibles
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 3 - Secondary Damage

Source:
    Herald of Ice (`skill-38`) - structural source candidate
Triggered By:
    None
Supported By:
    Overreach (`skill-39`)
    Elemental Armament II (`skill-40`)
    Elemental Focus (`skill-41`)
    Longshot II (`skill-42`)
    Direstrike I (`skill-43`)
Contributors:
    Overreach [Direct, Structural, Unresolved]
        Path: Overreach -SUPPORTS-> Herald of Ice
    Elemental Armament II [Direct, Structural, Unresolved]
        Path: Elemental Armament II -SUPPORTS-> Herald of Ice
    Elemental Focus [Direct, Structural, Unresolved]
        Path: Elemental Focus -SUPPORTS-> Herald of Ice
    Longshot II [Direct, Structural, Unresolved]
        Path: Longshot II -SUPPORTS-> Herald of Ice
    Direstrike I [Direct, Structural, Unresolved]
        Path: Direstrike I -SUPPORTS-> Herald of Ice
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 4 - Secondary Damage

Source:
    Spear Throw (`skill-44`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Damage Chain 5 - Secondary Damage

Source:
    Whirling Slash (`skill-9`) - structural source candidate
Triggered By:
    None
Supported By:
    Rapid Attacks III (`skill-10`)
    Rage III (`skill-11`)
    Heightened Accuracy II (`skill-12`)
    Rigwald's Ferocity (`skill-13`)
    Knockback (`skill-14`)
Contributors:
    Rapid Attacks III [Direct, Structural, Unresolved]
        Path: Rapid Attacks III -SUPPORTS-> Whirling Slash
    Rage III [Direct, Structural, Unresolved]
        Path: Rage III -SUPPORTS-> Whirling Slash
    Heightened Accuracy II [Direct, Structural, Unresolved]
        Path: Heightened Accuracy II -SUPPORTS-> Whirling Slash
    Rigwald's Ferocity [Direct, Structural, Unresolved]
        Path: Rigwald's Ferocity -SUPPORTS-> Whirling Slash
    Knockback [Direct, Structural, Unresolved]
        Path: Knockback -SUPPORTS-> Whirling Slash
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 6 - Trigger

Source:
    Profane Ritual (`skill-25`) - structural source candidate
Triggered By:
    Cast on Critical (`skill-24`)
Supported By:
    None
Contributors:
    Cast on Critical [Direct, Structural, Unresolved]
        Path: Cast on Critical -TRIGGERS-> Profane Ritual
    Boundless Energy II [Indirect, Structural, Unresolved]
        Path: Boundless Energy II -SUPPORTS-> Cast on Critical -> Cast on Critical -TRIGGERS-> Profane Ritual
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Trigger relationship validates activation compatibility only; no damage, rate, or propagation is inferred.
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 7 - Trigger

Source:
    Elemental Weakness (`skill-27`) - structural source candidate
Triggered By:
    Cast on Critical (`skill-24`)
Supported By:
    None
Contributors:
    Cast on Critical [Direct, Structural, Unresolved]
        Path: Cast on Critical -TRIGGERS-> Elemental Weakness
    Boundless Energy II [Indirect, Structural, Unresolved]
        Path: Boundless Energy II -SUPPORTS-> Cast on Critical -> Cast on Critical -TRIGGERS-> Elemental Weakness
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Trigger relationship validates activation compatibility only; no damage, rate, or propagation is inferred.
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 8 - Trigger

Source:
    Frost Bomb (`skill-28`) - structural source candidate
Triggered By:
    Cast on Critical (`skill-24`)
Supported By:
    None
Contributors:
    Cast on Critical [Direct, Structural, Unresolved]
        Path: Cast on Critical -TRIGGERS-> Frost Bomb
    Boundless Energy II [Indirect, Structural, Unresolved]
        Path: Boundless Energy II -SUPPORTS-> Cast on Critical -> Cast on Critical -TRIGGERS-> Frost Bomb
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Trigger relationship validates activation compatibility only; no damage, rate, or propagation is inferred.
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 9 - Trigger

Source:
    Flame Wall (`skill-29`) - structural source candidate
Triggered By:
    Cast on Critical (`skill-24`)
Supported By:
    None
Contributors:
    Cast on Critical [Direct, Structural, Unresolved]
        Path: Cast on Critical -TRIGGERS-> Flame Wall
    Boundless Energy II [Indirect, Structural, Unresolved]
        Path: Boundless Energy II -SUPPORTS-> Cast on Critical -> Cast on Critical -TRIGGERS-> Flame Wall
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Trigger relationship validates activation compatibility only; no damage, rate, or propagation is inferred.
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 10 - Utility

Source:
    Barrage (`skill-15`) - structural source candidate
Triggered By:
    None
Supported By:
    Heightened Charges (`skill-16`)
    Cooldown Recovery II (`skill-17`)
    Rapid Casting II (`skill-18`)
    Perpetual Charge (`skill-19`)
Contributors:
    Heightened Charges [Direct, Structural, Unresolved]
        Path: Heightened Charges -SUPPORTS-> Barrage
    Cooldown Recovery II [Direct, Structural, Unresolved]
        Path: Cooldown Recovery II -SUPPORTS-> Barrage
    Rapid Casting II [Direct, Structural, Unresolved]
        Path: Rapid Casting II -SUPPORTS-> Barrage
    Perpetual Charge [Direct, Structural, Unresolved]
        Path: Perpetual Charge -SUPPORTS-> Barrage
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 11 - Utility

Source:
    Sniper's Mark (`skill-20`) - structural source candidate
Triggered By:
    None
Supported By:
    Charge Profusion II (`skill-21`)
    Cooldown Recovery II (`skill-22`)
    Mark for Death (`skill-23`)
Contributors:
    Charge Profusion II [Direct, Structural, Unresolved]
        Path: Charge Profusion II -SUPPORTS-> Sniper's Mark
    Cooldown Recovery II [Direct, Structural, Unresolved]
        Path: Cooldown Recovery II -SUPPORTS-> Sniper's Mark
    Mark for Death [Direct, Structural, Unresolved]
        Path: Mark for Death -SUPPORTS-> Sniper's Mark
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 12 - Utility

Source:
    Cast on Critical (`skill-24`) - structural source candidate
Triggered By:
    None
Supported By:
    Boundless Energy II (`skill-26`)
Contributors:
    Boundless Energy II [Direct, Structural, Unresolved]
        Path: Boundless Energy II -SUPPORTS-> Cast on Critical
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 13 - Utility

Source:
    Charge Regulation (`skill-30`) - structural source candidate
Triggered By:
    None
Supported By:
    Uhtred's Exodus (`skill-31`)
Contributors:
    Uhtred's Exodus [Direct, Structural, Unresolved]
        Path: Uhtred's Exodus -SUPPORTS-> Charge Regulation
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 14 - Utility

Source:
    Combat Frenzy (`skill-32`) - structural source candidate
Triggered By:
    None
Supported By:
    Charge Profusion II (`skill-33`)
Contributors:
    Charge Profusion II [Direct, Structural, Unresolved]
        Path: Charge Profusion II -SUPPORTS-> Combat Frenzy
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 15 - Utility

Source:
    Purity of Fire (`skill-45`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Review Notes

- Companion: Frozen Mandibles: Minion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Companion: Frozen Mandibles: Companion ownership, actions, and damage attribution remain unmodeled; source is structural only.
- Herald of Ice: Herald effects/downstream interactions need future modeling.
- Profane Ritual: Charge generation/consumption and propagation remain unmodeled.
- Sniper's Mark: Mark application, target scope, and interactions need future modeling.
- Sniper's Mark: Charge generation/consumption and propagation remain unmodeled.
- Cast on Critical: Resource generation and downstream propagation remain unmodeled.
- Combat Frenzy: Charge generation/consumption and propagation remain unmodeled.
- Charge Profusion II SUPPORTS Sniper's Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Cooldown Recovery II SUPPORTS Sniper's Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Mark for Death SUPPORTS Sniper's Mark: compatibility evidence is valid; no effect/damage propagation is concluded.
- Brutus' Brain SUPPORTS Companion: Frozen Mandibles: compatibility evidence is valid; no effect/damage propagation is concluded.
- Overreach SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Elemental Armament II SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Elemental Focus SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Longshot II SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.
- Direstrike I SUPPORTS Herald of Ice: compatibility evidence is valid; no effect/damage propagation is concluded.

### gemling firesmasher

**Build file:** `Marauder\gemling firesmasher.xml`  
**Identity primary skill:** Molten Crash  
**Enabled active-set skills:** 32  
**Validated relationship edges:** 24  
**Contributor paths classified:** 24

| Build-level check | Result |
|---|---|
| Sources and members are valid build instances | PASS |
| Relationship evidence is validator-backed | PASS (23 foundation edge occurrences checked) |
| Contributor references resolve to classifications and validated paths | PASS (23 path edges checked) |
| No cycles / duplicate chains | PASS |
| No unsupported assumptions | PASS |
| Proven without propagation evidence | 0 |

--------------------------------------------------

#### Damage Chain 1 - Primary Damage

Source:
    Molten Crash (`skill-7`) - structural source candidate
Triggered By:
    None
Supported By:
    Xoph's Pyre (`skill-8`)
    Rigwald's Ferocity (`skill-9`)
    Close Combat II (`skill-10`)
    Elemental Armament II (`skill-11`)
    Rageforged II (`skill-12`)
Contributors:
    Xoph's Pyre [Direct, Structural, Unresolved]
        Path: Xoph's Pyre -SUPPORTS-> Molten Crash
    Rigwald's Ferocity [Direct, Structural, Unresolved]
        Path: Rigwald's Ferocity -SUPPORTS-> Molten Crash
    Close Combat II [Direct, Structural, Unresolved]
        Path: Close Combat II -SUPPORTS-> Molten Crash
    Elemental Armament II [Direct, Structural, Unresolved]
        Path: Elemental Armament II -SUPPORTS-> Molten Crash
    Rageforged II [Direct, Structural, Unresolved]
        Path: Rageforged II -SUPPORTS-> Molten Crash
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 2 - Secondary Damage

Source:
    Walking Calamity (`skill-1`) - structural source candidate
Triggered By:
    None
Supported By:
    Zerphi's Infamy (`skill-2`)
    Hourglass (`skill-3`)
    Elemental Armament II (`skill-4`)
    Prolonged Duration II (`skill-5`)
    Ambrosia II (`skill-6`)
Contributors:
    Zerphi's Infamy [Direct, Structural, Unresolved]
        Path: Zerphi's Infamy -SUPPORTS-> Walking Calamity
    Hourglass [Direct, Structural, Unresolved]
        Path: Hourglass -SUPPORTS-> Walking Calamity
    Elemental Armament II [Direct, Structural, Unresolved]
        Path: Elemental Armament II -SUPPORTS-> Walking Calamity
    Prolonged Duration II [Direct, Structural, Unresolved]
        Path: Prolonged Duration II -SUPPORTS-> Walking Calamity
    Ambrosia II [Direct, Structural, Unresolved]
        Path: Ambrosia II -SUPPORTS-> Walking Calamity
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 3 - Secondary Damage

Source:
    Herald of Ash (`skill-19`) - structural source candidate
Triggered By:
    None
Supported By:
    Magnified Area II (`skill-20`)
    Acrimony (`skill-21`)
    Prolonged Duration II (`skill-22`)
    Fire Mastery (`skill-23`)
Contributors:
    Magnified Area II [Direct, Structural, Unresolved]
        Path: Magnified Area II -SUPPORTS-> Herald of Ash
    Acrimony [Direct, Structural, Unresolved]
        Path: Acrimony -SUPPORTS-> Herald of Ash
    Prolonged Duration II [Direct, Structural, Unresolved]
        Path: Prolonged Duration II -SUPPORTS-> Herald of Ash
    Fire Mastery [Direct, Structural, Unresolved]
        Path: Fire Mastery -SUPPORTS-> Herald of Ash
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 4 - Trigger

Source:
    Ancestral Cry (`skill-25`) - structural source candidate
Triggered By:
    Ferocious Roar (`skill-24`)
Supported By:
    Efficiency II (`skill-26`)
    Prolonged Duration II (`skill-29`)
Contributors:
    Ferocious Roar [Direct, Structural, Unresolved]
        Path: Ferocious Roar -TRIGGERS-> Ancestral Cry
    Efficiency II [Direct, Structural, Unresolved]
        Path: Efficiency II -SUPPORTS-> Ancestral Cry
    Prolonged Duration II [Direct, Structural, Unresolved]
        Path: Prolonged Duration II -SUPPORTS-> Ancestral Cry
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Trigger relationship validates activation compatibility only; no damage, rate, or propagation is inferred.
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 5 - Utility

Source:
    Purity of Fire (`skill-13`) - structural source candidate
Triggered By:
    None
Supported By:
    Vitality II (`skill-14`)
    Precision II (`skill-15`)
    Clarity II (`skill-16`)
    Herbalism II (`skill-17`)
    Cool Headed (`skill-18`)
Contributors:
    Vitality II [Direct, Structural, Unresolved]
        Path: Vitality II -SUPPORTS-> Purity of Fire
    Precision II [Direct, Structural, Unresolved]
        Path: Precision II -SUPPORTS-> Purity of Fire
    Clarity II [Direct, Structural, Unresolved]
        Path: Clarity II -SUPPORTS-> Purity of Fire
    Herbalism II [Direct, Structural, Unresolved]
        Path: Herbalism II -SUPPORTS-> Purity of Fire
    Cool Headed [Direct, Structural, Unresolved]
        Path: Cool Headed -SUPPORTS-> Purity of Fire
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 6 - Utility

Source:
    Berserk (`skill-30`) - structural source candidate
Triggered By:
    None
Supported By:
    Uhtred's Exodus (`skill-31`)
Contributors:
    Uhtred's Exodus [Direct, Structural, Unresolved]
        Path: Uhtred's Exodus -SUPPORTS-> Berserk
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    Contributor paths remain Structural; indirect propagation is Unresolved.

--------------------------------------------------

#### Damage Chain 7 - Utility

Source:
    Virtuous Barrier (`skill-34`) - structural source candidate
Triggered By:
    None
Supported By:
    None
Contributors:
    None
Validation:

    ✅ Source valid (build identity + exact mechanics record)
    ✅ Relationships valid (accepted SUPPORTS/TRIGGERS evidence)
    ✅ Contributors valid (classifier output + accepted path edges)
    ✅ Chain membership valid
    ✅ No orphaned chain members; each member appears in source, edge, or path evidence

Notes:
    No DPS, ranking, damage weighting, or propagation conclusion is made.

--------------------------------------------------

#### Review Notes

- Herald of Ash: Herald effects/downstream interactions need future modeling.
- Magnified Area II SUPPORTS Herald of Ash: compatibility evidence is valid; no effect/damage propagation is concluded.
- Acrimony SUPPORTS Herald of Ash: compatibility evidence is valid; no effect/damage propagation is concluded.
- Prolonged Duration II SUPPORTS Herald of Ash: compatibility evidence is valid; no effect/damage propagation is concluded.
- Fire Mastery SUPPORTS Herald of Ash: compatibility evidence is valid; no effect/damage propagation is concluded.

## Global Checks

| Check | Count |
|---|---:|
| Cycles | 0 |
| Duplicate chain IDs or duplicate sources | 0 |
| Invalid endpoints | 0 |
| Out-of-build endpoints | 0 |
| Unsupported relationship/contributor assumptions | 0 |
| Proven classifications without explicit propagation evidence | 0 |

The real-build structural validation passed only when all listed edge/path evidence resolves to accepted results. Any source candidate remains a structural classification; this report makes no DPS, source ranking, or propagation claim. No application behavior was changed.

## Manual Review Checklist

Review was performed against the active build XML identity, exact mechanics matches, validator-accepted relationship instances, contributor classifications, and each emitted chain above. These checks establish structural membership; they do not establish actual in-game damage, uptime, or effect magnitude.

### Structure and relationship checks

- [x] Every chain source, trigger, support, and contributor is an enabled skill instance in the selected active build skill set.
- [x] Every displayed contributor has a corresponding classifier-produced path; every path edge matches a validator-accepted relationship and carries evidence.
- [x] No orphaned nodes, invalid endpoints, or out-of-build endpoints were found.
- [x] No duplicate chain IDs or duplicate source-instance chains were found. Repeated names on separate socket-group skill instances (for example, Spirit Vessel) remain separate build instances, not duplicate chains.
- [x] No duplicate contributor source instance occurs within a chain.
- [x] Every validated `SUPPORTS`/`TRIGGERS` edge has same-socket-group endpoints; the audit found zero cross-group accepted edges.
- [x] Trigger chains are attached to their validated target source; all four Cast on Critical targets appear once each in separate chains.
- [x] Supports remain attached to their exact validated targets. Boundless Energy II directly supports Cast on Critical; its paths to triggered targets remain indirect, Structural, and Unresolved.
- [x] Contributor classifications remain Structural and Unresolved. No Proven classification or propagation assumption appears.
- [x] Unrelated source instances remain separate chains; trigger relationships do not collapse them into one chain.
- [x] Chain nodes and relationships are accounted for by source, accepted edge, or classified path evidence. Completeness against any unmodeled PoB behavior is not claimed.

### Source-role review

- [ ] **Potential source-role concern:** the foundation accepts the mechanics type `Attack` by itself as a damage-source candidate. `Attack` establishes an attack category, not explicit damage facts in this model. Consequently, several chains below are structurally traceable but should not be treated as confirmed damage sources.
- [ ] **Confirmed suspicious classifications for follow-up:** Herald of Ice and Herald of Thunder in Spin to Win, Herald of Ice in Whirling Twisters, and Herald of Ash in gemling firesmasher are emitted as Secondary Damage chains even though their mechanics identify them as Herald/Buff and do not declare `Damage` or `DamageOverTime`. These utility skills therefore appear as damage candidates by mistake under a strict damage-source interpretation.
- [ ] Other Attack-only source candidates are also provisional. Mechanics records for Twister, Whirling Assault, Quarterstaff Strike, Tempest Bell, Shattering Palm, Hollow Focus, Hand of Chayula, Pounce, Hollow Form, Spear Throw, Whirling Slash, Molten Crash, and Walking Calamity do not declare `Damage`/`DamageOverTime` in the reviewed records. The reports correctly label them structural candidates, but source status needs a narrower evidence rule before Damage Chain Classification.
- [x] Cast on Critical is represented as a Utility/trigger-provider context, not as a damage chain source. Its four validated target edges are activation relationships only.
- [x] Elemental Weakness triggered by Cast on Critical remains a Trigger chain rather than being classified as a damage source from its curse mechanics.
- [x] Minion/companion-family candidates (Spirit Vessel and Companion: Frozen Mandibles) are explicitly called out for future attribution modeling; their presence does not prove minion/companion attacks or damage.
- [x] Marks, charge/resource generation, Heralds, minions, companions, and support interactions are reported as future-modeling review notes, not as propagated effects.

The unchecked source-role items are validation findings, not permission to change this phase's implementation. Phase 4D.2 does not modify the foundation. They should be resolved by a separately scoped evidence/classification design before any source classification or resolver replacement is attempted.

## Reviewer Summary

### Spin to Win Monk 0.5.5

- **Chains that look structurally correct:** all 20 emitted chain source instances exist in the build, have a unique mechanics record, and retain active-set context. All 36 contributor path-edge occurrences resolve to accepted, evidenced relationships. The four direct supports on Whirling Assault and each support attached to its own target remain separate.
- **Chains requiring future modeling:** Spirit Vessel instances require minion/companion ownership and damage attribution; Freezing Mark and Herald/charge/resource skills require target/effect semantics. The report's review notes list these explicit cases.
- **Suspicious chains:** Herald of Ice and Herald of Thunder are classified Secondary Damage from `Attack` types despite having Herald/Buff mechanics and no explicit `Damage`/`DamageOverTime`. Several other `Attack`-only skills are provisional candidates, not confirmed sources.
- **Recommendation before Damage Chain Classification:** do not treat Attack-only, Herald/Buff, or Minion/Companion type membership as proof of damage production. Establish a source-evidence rule and mark ambiguous candidates explicitly.

### Whirling Twisters

- **Chains that look structurally correct:** Twister remains a separate primary candidate. The four Cast on Critical edges resolve to Profane Ritual, Elemental Weakness, Frost Bomb, and Flame Wall in socket group 5; each target has one trigger chain and one evidenced trigger edge. No cross-group edges or duplicate trigger chains were found. Boundless Energy II's direct support edge remains on Cast on Critical; the two-hop paths are Indirect/Structural/Unresolved.
- **Chains requiring future modeling:** ground-effect interactions, Frozen Mandibles ownership/action/damage, Herald of Ice, Sniper's Mark, charge generation, and trigger-target effect behavior need mechanics beyond the validated edge facts.
- **Suspicious chains:** Herald of Ice is emitted as Secondary Damage without explicit `Damage`/`DamageOverTime`; Twister, Spear Throw, and Whirling Slash are Attack-only source candidates. Elemental Weakness is correctly represented as a triggered utility target, not a damage source.
- **Recommendation before Damage Chain Classification:** retain the four trigger-target chains as activation structures, but defer source confirmation and all indirect propagation.

### gemling firesmasher

- **Chains that look structurally correct:** Molten Crash remains a distinct primary candidate; Ancestral Cry is represented as a trigger target of Ferocious Roar with its exact supports, all in socket group 5. No cycle, duplicate, invalid endpoint, out-of-build node, or unsupported evidence was found.
- **Chains requiring future modeling:** Ancestral Cry's buff/charge consumption and Ferocious Roar's trigger semantics beyond validated compatibility require effect and condition modeling; Herald of Ash requires Herald interaction semantics.
- **Suspicious chains:** Herald of Ash appears as Secondary Damage without explicit `Damage`/`DamageOverTime`. Molten Crash and Walking Calamity are Attack-only source candidates, so their source classification remains provisional.
- **Recommendation before Damage Chain Classification:** separately validate attack source roles and ensure Herald/Buff skills cannot be promoted solely by an `Attack` type.

### Overall recommendation

The foundation passes **structural evidence validation**: every emitted relationship and contributor path traces to the validated upstream results, all trigger targets are correctly scoped, and the audits found zero cycles, duplicates, invalid endpoints, out-of-build endpoints, or unsupported edge assumptions. The manual review does **not** pass source-role validation: multiple Herald/Buff utility skills are labeled Secondary Damage because `Attack` is currently accepted as source evidence. Resolve that concern in a future, explicitly scoped source-classification change before relying on chain categories for downstream classification or optimization.
