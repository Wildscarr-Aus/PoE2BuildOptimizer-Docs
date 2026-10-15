\# PoE2 Build Optimizer - Project Handoff



\## Current Status



\### Phase 4B-3

Status: COMPLETE



Completed:

\- SkillIdentity

\- SkillSignature

\- SkillRelationships

\- DamageChainReport

\- DamageChainResolver

\- Real-build validation

\- Relationship graph foundations



\---



\### Phase 4B-4A

Status: COMPLETE



Completed:

\- Extracted DamageChainRecord into its own module.

\- Created canonical DamageChainRecord in:



&#x20;   Src/Analysis/damage\_chain\_record.py



\- Updated DamageChainResolver to import and use canonical model.

\- Updated tests.

\- Refactor validated.

\- Resolver, report and record tests passing.

\- 25 tests passing after refactor.



Current ownership:



damage\_chain\_record.py

&#x20;   DamageChainRecord



damage\_chain\_resolver.py

&#x20;   DamageChainResolver

&#x20;   resolve\_damage\_chain()



\---



\## Current Active Phase



\### Phase 4B-4B

Status: IN PROGRESS



Working Title:



Damage Source Promotion \& Classification



\---



\## Current DamageChainRecord



Current model includes:



\- primary\_skill

\- damage\_source

\- damage\_sources

\- active\_subskill

\- weapon\_set



Collections:



\- enablers

\- amplifiers

\- supports

\- triggered\_skills

\- related\_skills



Important:



damage\_source != damage\_sources



damage\_sources represents all meaningful damage contributors.



damage\_source represents the currently selected primary contributor.



\---



\# Major Architectural Discovery



Initial assumption:



Triggered Skill

&#x20;   ->

Becomes Damage Source



This is now considered too simplistic.



Real-world PoE2 build analysis has shown that builds frequently contain multiple meaningful damage contributors.



The optimizer should model:



\- Damage Sources

\- Triggers

\- Enablers

\- Amplifiers

\- Supports



rather than attempting to identify only one damage skill.



\---



\# Classification Model



\## Damage Sources



Skills directly contributing meaningful damage.



Examples:



\- Lightning Arrow

\- Comet

\- Twister

\- Frost Bomb



\---



\## Triggers



Skills or mechanics that activate other skills.



Examples:



\- Cast on Critical

\- Cast on Shock

\- Cast on Freeze



\---



\## Enablers



Skills or mechanics required to generate or improve damage output.



Examples:



\- Spell Totem

\- Ballista Totem

\- Lightning Rod



\---



\## Amplifiers



Skills or mechanics increasing damage effectiveness.



Examples:



\- Shock

\- Exposure

\- Curses



\---



\## Supports



Traditional support relationships.



\---



\# Real Build Validation



\## Lightning Arrow / Cast on Crit Build



Observed build behaviour:



Lightning Rod

&#x20;   ->

Improves Lightning Arrow crit generation



Lightning Arrow

&#x20;   ->

Primary attack



Lightning Arrow Crit

&#x20;   ->

Cast on Critical



Cast on Critical

&#x20;   ->

Comet



Comet

&#x20;   ->

Additional damage



Classification:



Damage Sources:

\- Lightning Arrow

\- Comet



Trigger:

\- Cast on Critical



Enabler:

\- Lightning Rod



Important:



Lightning Rod is NOT considered a damage source.



Lightning Rod is considered an enabler/amplifier.



\---



\## Additional Lightning Arrow Discovery



Lightning Arrow itself contains multiple internal damage events:



\- Projectile Hit

\- Beam Hit



Observed example:



Projectile DPS \~ 75k

Beam DPS \~ 80k



Frequency varies.



Conclusion:



Phase 4B-4B should identify contributors and relationships.



Phase 4B-4B should NOT yet perform detailed DPS weighting or rotation analysis.



\---



\## Twister Validation



Previously validated:



Twister

&#x20;   ->

Ground Effect

&#x20;   ->

Damage



Important conclusion:



Builds behave as damage ecosystems.



The optimizer must understand relationships rather than simply selecting a single skill.



\---



\# Rule 001



\## Original Idea



Triggered Skill Replacement



Definition:



A triggers B



\-> B replaces damage source



Status:



REJECTED



\---



\## Revised Rule 001



Triggered Skill Promotion



Definition:



A triggers B



Then:



\- B becomes a damage-source candidate.

\- Existing damage sources remain valid.

\- Trigger relationships are preserved.

\- Enablers are preserved.



Examples:



Cast on Critical

&#x20;   ->

Comet



Result:



Damage Sources:

\- Existing sources

\- Comet



Trigger:

\- Cast on Critical



Do NOT automatically replace damage\_source.



Promote into damage\_sources.



\---



\# Important Design Principle



Detection logic must remain:



RELATIONSHIP DRIVEN



and NOT:



SKILL NAME DRIVEN



Avoid:



if skill\_name == "SomeSkill":



Prefer:



RelationshipType.TRIGGERS

RelationshipType.ENABLES

RelationshipType.AMPLIFIES

RelationshipType.SUPPORTS



Future game-specific intelligence should come from:



Skill / Support / Mechanic Rules Engine



not hard-coded skill names.



\---



\# Current Test State



Completed:



\- DamageChainRecord extraction.

\- Canonical model validation.

\- Resolver validation.

\- Report validation.



Trigger Detection Test:



Created.



Current outcome:



FAILING BY DESIGN



Reason:



Test currently assumes triggered skill replaces damage\_source.



Architecture discussion indicates that this assumption is likely incorrect.



Test should be reviewed and updated to validate Triggered Skill Promotion.



\---



\# Next Coding Session



Starting Point:



Review:



&#x20;   Src/Analysis/damage\_chain\_resolver.py



Focus on:



\- damage\_sources

\- promoted\_sources

\- promoted\_from



Goal:



Implement Rule 001 as:



Triggered Skill Promotion



rather than:



Triggered Skill Replacement



Expected outcome:



Triggered skills become damage-source candidates while preserving existing contributors.



No direct replacement of damage\_source until contributor ranking exists.



\---



\# Immediate Next Task



Before coding:



1\. Review current trigger test.

2\. Update test expectations to align with Triggered Skill Promotion.

3\. Validate against:

&#x20;   - Cast on Crit builds

&#x20;   - Twister builds

&#x20;   - Multi-source builds



Only then modify resolver promotion logic if required.



\---



END OF HANDOFF



