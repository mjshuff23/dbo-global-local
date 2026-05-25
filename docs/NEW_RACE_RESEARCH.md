# Researching A New Race Or Transformation

This is a research map, not an implementation plan. A Saiyan-style idea contains two separable projects:

- A new playable race or class, which changes creation, validation, persistence, tables, UI, models, and protocol-visible values.
- Transformation or cosmetic behavior for an existing human character, which may reuse the existing Super Saiyan transformation path and is a much smaller first experiment.

## Confirmed Source Facts

| Area | Evidence in this checkout | Why it matters |
| --- | --- | --- |
| Existing races | `DboShared/NtlShared2/NtlCharacter.h` defines `RACE_HUMAN`, `RACE_NAMEK`, and `RACE_MAJIN` with `RACE_COUNT`/`RACE_LAST`. | A fourth race expands shared enum and array contracts. |
| Existing classes | The same header defines first- and second-stage `ePC_CLASS` values and class flags. | Items, skills, UI labels, and validation may be keyed by class or flags. |
| Character creation protocol | `DboShared/NtlShared2/NtlPacketUC.h` includes `byRace` and `byClass` in `sUC_CHARACTER_ADD_REQ`. | Client and CharServer share a binary request contract. |
| Server validation | `DboServer/Server/CharServer/PacketCharServer.cpp` accepts only known race/class pairings and loads newbie table data for the request. | A new playable race cannot be created by UI changes alone. |
| Persistence path | `DboServer/Server/QueryServer/CharPacket.cpp` processes the character-add request after CharServer validation. | Database persistence must be traced and tested. |
| Table indexing | `DboShared/NtlGameTable/PCTable.h` and `NewbieTable.h` allocate data using `RACE_COUNT` and `PC_CLASS_COUNT`. | New IDs require compatible table data and careful range/index review. |
| Client creation UI | `DboClient/Client/Gui/CharMakePartGui.cpp`, `RaceExplainGui.cpp`, and `ClassExplainGui.cpp` switch explicitly over the three races/classes. | Selection buttons, labels, and preview inputs require deliberate additions. |
| Lobby presentation | `DboClient/Client/Stage/LobbyStage.cpp` stores camera/background setup per race. | Character preview needs placement and background behavior. |
| Visual mapping | `DboClient/Lib/NtlPresentation/NtlDefaultItemData.cpp` selects visuals by race and already contains Super Saiyan face/head data lookups. | Hair/body/equipment changes are presentation and asset work. |
| Existing transform state | `DboShared/NtlShared2/NtlCharacterState.h` and `DboServer/Server/GameServer/AspectState_SuperSaiyan.cpp` already define/runtime-handle `ASPECTSTATE_SUPER_SAIYAN`. | A transformation prototype may be safer than a new race. |

## Two Sensible Experiments

### Experiment A: Cosmetic transformation on an existing human

Goal: learn the presentation/effect/asset pipeline without extending the shared race schema.

Investigate:

- `DboServer/Server/GameServer/AspectState_SuperSaiyan.cpp` for authoritative transformation lifetime/EP behavior.
- `DboClient/Lib/NtlPresentation/NtlDefaultItemData.cpp` for existing Super Saiyan face/head lookups.
- `DboClient/Lib/NtlSimulation/NtlSLVisualDeclear.h` for existing transformation visual IDs.
- Local client assets in the ignored `DboClient/DragonBall` payload for model/effect availability.

Possible success criterion: an existing human transformation shows a deliberately changed test hair/effect asset in an isolated client payload, while server behavior and the known-good client remain unchanged.

### Experiment B: New playable race

Goal: introduce a real fourth race only after its full contract is mapped.

Required investigation areas:

1. Shared IDs and protocol: `NtlCharacter.h`, packet structs, race/class flags, result codes.
2. Tables: PC, newbie, item restriction, skill, model/animation, starting data, and any RDF/packed resource source.
3. Server: CharServer validation, QueryServer persistence, GameServer loading/runtime assumptions, Chat/social race metadata.
4. Client: creation GUI, strings/icons, lobby camera/background, simulation attributes, presentation/model/equipment mapping.
5. Assets/tools: body/head/hair/tail models, skeleton and bone attachment, animations, textures, effects, packaging and localization.

## Research Deliverables Before Implementation

Produce these artifacts before an agent changes shared race IDs:

1. A symbol inventory listing every `RACE_*`, `RACE_COUNT`, `PC_CLASS_*`, and race-indexed table or array consumer.
2. A character-creation sequence diagram from UI selection through QueryServer persistence and world entry.
3. An asset manifest for model, skeleton, hair, tail attachment, animation, effect, icon, and string requirements.
4. A database/table migration plan with backup and rollback instructions.
5. A phased acceptance plan: cosmetic prototype, private creation flow, persistence/load, world entry, multiplayer visibility, then gameplay/balance.

## Agent Guardrails

- Do not begin a new-race implementation by only appending an enum value.
- Do not modify binary/shared packet layouts without matching client and server builds.
- Do not commit proprietary or downloaded client assets without confirming rights.
- Do not overwrite the known-good playable payload; deploy experiments to a separate local client directory.
- Prefer a visual/transformation proof first if the learning goal is tails, hair swaps, or aura effects.
