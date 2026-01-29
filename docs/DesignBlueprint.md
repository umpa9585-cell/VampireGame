# VampireGame — Design Blueprint

## Purpose
This blueprint translates the high-level vision into actionable design decisions, informed by genre expectations and known strengths/weaknesses of comparable vampire action RPGs.

## Creative North Star
Build a modern London vampire RPG where player choice, predatory fantasy, and moral consequence drive a living city. The world should feel stylish and dangerous, while combat and traversal stay fluid on iPad.

## Inspiration Synthesis
### The Vampire Diaries (TVD) Influence
- **Mythos Tone:** Supernatural politics, bloodline secrets, and morally ambiguous protagonists.
- **Humanity Dial:** Inspired by TVD’s humanity concept, but reimagined as a continuous meter that shifts dynamically rather than a binary switch.
- **Character Drama:** Personal relationships and faction tensions drive story stakes.

### Vampyr (Game) Lessons
**Strengths to Emulate**
- Atmospheric worldbuilding and strong narrative focus.
- Meaningful feeding choices that ripple across the city.

**Pain Points to Avoid**
- Repetitive combat pacing and difficulty spikes.
- Overreliance on dialogue bottlenecks.
- Limited player expression in traversal and stealth.

## Market Feedback Themes (Genre Expectations)
- **Players Love:** Narrative consequence, reactive NPCs, and a strong vampire fantasy loop (hunt → feed → evolve).
- **Players Dislike:** Grind-heavy progression, flat combat feel, and punishing difficulty spikes without clarity.
- **Mobile Expectations:** Responsive controls, readable UI, and short-session friendly loops without sacrificing depth.

## Core Systems Blueprint
### Humanity System (Continuous Meter)
- **Meter Range:** 0–100, constantly drifting based on actions, feeding behavior, and story choices.
- **Dynamic States:**
  - **Predatory Drift (0–30):** More brutal powers, civilians fear you, hunters are more aggressive.
  - **Balanced Shadow (31–70):** Neutral access to social and combat options, stable city response.
  - **Veil of Mercy (71–100):** Stronger social/stealth tools, safer districts, fewer violent outcomes.
- **Decay & Recovery:** Humanity decays slowly at night if predatory actions dominate, but can be restored via restraint, acts of compassion, or sparing key NPCs.
- **Narrative Hooks:** Dialogue lines, faction trust, and quest outcomes branch based on meter thresholds.

### Feeding & Consequences
- **Target Tiers:** Civilians, criminals, faction elites, and supernatural adversaries.
- **Risk vs Reward:** High-value targets deliver stronger blood but drastically affect district stability.
- **District Health:** Feeding choices alter local economy, security, and event frequency.

### Combat & Mobility
- **Tactile Combat:** Light/heavy chains, stagger windows, and optional “blood burst” finishers.
- **Traversal:** Rooftop stalking, wall-run vaults, shadow teleports, and dynamic drop ambushes.
- **Stealth Loop:** Line-of-sight tools, distraction gadgets, and mist form bypass routes.

### Open World Structure
- **District Streaming:** London split into 5–6 dense districts with unique night identities.
- **Event System:** Faction raids, hunter ambushes, rescue scenarios.
- **Safe Houses:** Upgrade hubs for crafting, skill allocation, and story encounters.

## Story & Progression Blueprint
- **Acts:** 3-act arc with escalating faction conflict and the Masquerade crisis.
- **Bloodlines:** Shadow, Blood, Beast. Each branch affects combat style and social options.
- **Faction Influence:** Reputation shifts unlock exclusive quests and equipment.

## UX & Mobile Considerations
- **Input:** Gesture-based quick actions with optional controller support.
- **Performance Targets:** 30–60 FPS with scalable effects.
- **Session Design:** 10–20 minute activity loops with autosave checkpoints.

## Moddability Roadmap
- **Phase 1:** Curated cosmetic and data-driven tuning mods.
- **Phase 2:** Visual scripting for quests/events.
- **Phase 3:** Community events and seasonal mod spotlights.

## Risks & Mitigations
- **Combat Fatigue:** Add build diversity and stealth alternatives.
- **Narrative Bottlenecks:** Provide optional stealth or combat routes for key objectives.
- **Mobile Constraints:** Keep crowd density scalable and limit heavy AI counts in hotspots.
