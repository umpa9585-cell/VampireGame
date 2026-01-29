# Key Research: Core Systems Deep Dive

This document collects research notes, design references, and implementation ideas for several complex gameplay systems. It is organized by system with design goals, models, data structures, algorithms, tuning levers, and risks. The intent is to support implementation planning and iterative prototyping.

## 1) Complex Weather Algorithm

### Design Goals
- **Immersion:** Weather should feel regional, seasonal, and dynamic without becoming chaotic.
- **Gameplay impact:** Weather affects visibility, movement, NPC behavior, combat accuracy, and narrative tone.
- **Forecastability:** Players can anticipate changes via tells (sky conditions, NPC chatter, forecasts).

### Core Model: Multi-Layer Weather State
Represent weather using layered state rather than a single "weather type" enum.

**State layers:**
- **Macro climate:** season, biome, altitude, latitude.
- **Synoptic system:** pressure, humidity, frontal systems (warm/cold fronts), storm cells.
- **Local conditions:** cloud cover, wind speed/direction, precipitation type, temperature, fog density, lightning probability.

### Recommended Algorithm
1. **Climate baseline:**
   - Use seasonal curves and biome tables to define temperature and humidity baselines.
   - Example: `T_base = season_curve(day) + biome_offset + altitude_lapse`.
2. **Synoptic evolution:**
   - Simulate pressure fields using coarse grid nodes (e.g., 8–16 nodes across map).
   - Pressure gradient drives wind. Weather fronts emerge by diffusing pressure over time.
3. **Local stochastic modulation:**
   - Use procedural noise (Perlin/Simplex) to modulate micro-variations.
   - Add event drivers: storms form when humidity + instability thresholds are exceeded.
4. **Precipitation model:**
   - Determine precipitation type by temperature banding.
   - Determine intensity by humidity, vertical instability, and wind convergence.

### Data Structures
- **ClimateProfile:** biome/season-based base values.
- **WeatherCell:** grid cell with pressure, humidity, temperature, wind.
- **LocalWeather:** derived per location with smoothing and noise.

### Tuning Levers
- Storm frequency, transition speed, intensity scaling.
- Seasonal length, daily temp swing, humidity caps.

### Player-Facing Systems
- In-game forecast: a probability readout rather than certainty.
- Environmental cues: cloud strata types, wind audio, changing sunlight.

### Risks / Mitigations
- **Chaos:** too much randomness → enforce momentum with inertia-based state updates.
- **Performance:** use low-resolution synoptic grid and local interpolation.

### Design Stages
1. **Stage 1: Climate Baseline** — implement seasonal curves, biome offsets, and daily temperature swing.
2. **Stage 2: Synoptic Layer** — add pressure grid, wind gradients, and front evolution.
3. **Stage 3: Local Variance** — integrate noise-based micro-variation and localized fog.
4. **Stage 4: Storm Events** — add storm cell formation rules, lightning, and precipitation intensity.
5. **Stage 5: Gameplay Hooks** — wire weather into visibility, NPC reactions, and combat modifiers.

---

## 2) Immersive Choice-Based Dialogue System

### Design Goals
- **Agency:** choices matter; different paths yield distinct outcomes.
- **Reactivity:** NPCs remember past choices.
- **Character voice:** choices reflect personality (tone, morality, manipulative subtext).

### Core Concepts
- **Dialogue Graph:** nodes with lines + conditionals + effects.
- **Dynamic gating:** options appear based on faction, humanity, skill checks, or reputation.
- **Memory tokens:** dialogue outcomes store memory events that affect future nodes.

### Structure
- **Nodes**
  - `Text`, `Speaker`, `Mood`, `Tags`.
- **Choices**
  - `Requirements` (skill, faction, humanity range).
  - `Effects` (reputation shifts, flags).

### Algorithm
1. Gather all candidate nodes for context (quest, scene, NPC state).
2. Filter nodes by requirements.
3. Score options with weights (tone matching, NPC preference, player history).
4. Display 3–6 options with tone indicators, unlock icons, and locked previews.

### Enhancements
- **"Soft" choices:** the choice exists but is framed differently if prerequisites unmet.
- **Deception/Insight layers:** highlight subtext if skill is high.
- **Delayed consequences:** store tokens that activate later.

### Design Stages
1. **Stage 1: Dialogue Graph** — establish node/choice schema and basic branching.
2. **Stage 2: Conditions & Effects** — add gating rules and memory tokens.
3. **Stage 3: Reactivity** — wire to reputation, humanity, and faction states.
4. **Stage 4: Presentation** — add tone indicators, locked previews, and subtext cues.
5. **Stage 5: Persistence** — test long-term consequences with delayed triggers.

---

## 3) Deep Gated Skill Tree

### Design Goals
- **Meaningful progression:** choices lock out others or change playstyle.
- **Readability:** players understand the consequences.
- **Build diversity:** multiple viable build paths.

### Model
- **Skill nodes** with properties: cost, prereqs, category, tier, synergy.
- **Gates** based on faction allegiance, humanity, and narrative milestones.

### Gating Types
- **Hard gates:** require quest completion or faction rank.
- **Soft gates:** require resources or sacrifice (e.g., cost resets).

### Algorithm
- Evaluate unlock conditions per node.
- Provide a preview of unlock effects.

### Sample Structure
- Tiered trunks: offense/defense/control/utility.
- Cross-branch synergies with multiple micro nodes.

### Risks
- Too many nodes = overwhelm → create clusters with meta-nodes.

### Design Stages
1. **Stage 1: Core Tree** — define tiers, categories, and baseline nodes.
2. **Stage 2: Gates** — implement quest/faction/humanity prerequisites.
3. **Stage 3: Synergy** — add cross-branch nodes and combo effects.
4. **Stage 4: Balance** — tune costs, unlock cadence, and respec rules.
5. **Stage 5: UX Polish** — add previews and build comparisons.

---

## 4) Deep Immersive Humanity System

### Design Goals
- **Narrative weight:** player decisions influence humanity (moral state).
- **Gameplay impact:** humanity affects access to powers, NPC reactions, and choices.

### Model
- **Humanity Score (0–100)**
- **Threshold tiers** (e.g., saintly, balanced, cold, monstrous)

### Input Sources
- **Actions:** feeding, mercy, betrayals.
- **Dialogue choices:** cruelty vs empathy.
- **Factions:** alignment with specific ideologies.

### Algorithm
- Score changes aggregated by event weight.
- Apply decay and recovery windows.

### Gameplay Effects
- NPC fear or trust.
- Skill tree gates (dark powers vs compassionate powers).
- Combat modifiers (e.g., frenzy risk at low humanity).

### Design Stages
1. **Stage 1: Scoring Model** — define score ranges and tier labels.
2. **Stage 2: Event Weights** — implement action-based deltas and recovery windows.
3. **Stage 3: System Hooks** — gate skills and alter dialogue availability.
4. **Stage 4: World Reaction** — NPC behavior and faction reputation shifts.
5. **Stage 5: Feedback** — add UI indicators and narrative tells.

---

## 5) Factions System

### Design Goals
- **Dynamic political world:** factions compete, ally, and betray.
- **Player reputation:** influences access, quests, and NPCs.

### Core Model
- **Faction objects**: ideology, enemies, allies, territory, leadership.
- **Reputation matrix**: player and faction standings.

### Algorithms
- **Influence simulation:**
  - Each faction has resources and goals.
  - Periodic tick updates resolve actions (war, diplomacy, trade).
- **Reputation cascade:**
  - If you help faction A, factions aligned with A gain small reputation.

### Player Effects
- Access to faction-exclusive skills and weapons.
- Reputation threshold unlocks quests.

### Design Stages
1. **Stage 1: Data Model** — define faction metadata, alignments, and leader states.
2. **Stage 2: Reputation** — implement player standings and reputation cascades.
3. **Stage 3: Simulation** — add influence ticks and faction actions.
4. **Stage 4: Content Hooks** — integrate quests, vendors, and safehouses.
5. **Stage 5: Narrative Dynamics** — handle betrayal, alliances, and takeovers.

---

## 6) Combat Algorithm

### Design Goals
- **Tactical depth** with clarity.
- **Skill expression** via timing, positioning, and status effects.

### Core Model
- **Stats:** attack, defense, speed, precision, resilience.
- **Context:** weapon type, stance, weather, humanity, fatigue.

### Resolution Algorithm
1. Compute base hit chance (precision vs evasion).
2. Apply modifiers (weather, stance, injuries, status effects).
3. Determine hit/miss/critical.
4. Compute damage: `(base damage * modifiers) - mitigation`.
5. Apply status effects and stagger.

### Advanced Features
- **Resource systems:** stamina/blood.
- **Combo chains:** attacks feed into a meter.
- **AI tactics:** adaptive to player style.

### Design Stages
1. **Stage 1: Core Loop** — implement hit/miss, damage, and mitigation.
2. **Stage 2: Modifiers** — apply weather, stance, status effects, and fatigue.
3. **Stage 3: Resources** — add stamina/blood costs and recovery.
4. **Stage 4: Advanced Moves** — combos, stagger, and critical variations.
5. **Stage 5: Tuning** — analytics-backed balancing and encounter pacing.

---

## 7) NPC Algorithm (Immersive and Realistic)

### Design Goals
- **Believable behavior:** NPCs have goals, schedules, and emotional states.
- **Reactivity:** NPCs respond to player actions, world state, and faction shifts.

### Model
- **Behavior tree** or **utility AI**.
- **Memory system:** short-term and long-term memories.
- **Needs system:** hunger, fear, curiosity, loyalty.

### Algorithm
1. Update needs (decay/increase).
2. Evaluate available actions with utility scoring.
3. Select action with highest utility.
4. Execute and update memory.

### Enhancements
- **Schedules:** routine behaviors anchored to time.
- **Rumor system:** NPCs spread stories that affect reputation.

### Design Stages
1. **Stage 1: Core AI** — implement behavior tree or utility AI framework.
2. **Stage 2: Needs & Memory** — add needs decay, memory tokens, and priorities.
3. **Stage 3: Schedules** — time-based routines and location anchors.
4. **Stage 4: World Reactivity** — respond to player actions and faction shifts.
5. **Stage 5: Social Simulation** — rumors, alliances, and emergent reactions.

---

## Implementation Suggestions

### Phased Development
1. **Prototype baseline systems** in isolation.
2. **Integrate with core gameplay loops**.
3. **Add narrative hooks and tuning**.

### Cross-System Interactions
- Weather impacts combat, NPC behavior, and dialogue triggers.
- Humanity gates skill tree nodes and faction standing.

### Tooling
- **Simulation debug view:** visualize weather, AI decisions, faction shifts.
- **Telemetry logs:** record player choices and system outcomes.

---

## Next Steps
- Define constants, curves, and tuning values.
- Build sample datasets for NPC and faction states.
- Add playtest scenarios to validate system interactions.
