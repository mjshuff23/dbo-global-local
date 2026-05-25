# DboClient/Client/Stage

`Stage` is the client's high-level runtime state flow. A useful web analogy is route-level application state, but with stronger lifecycle constraints because the client owns network sessions, loading screens, world transitions, asset readiness, and game-loop participation.

## Typical responsibilities

- Login flow and server selection.
- Character selection/creation flow.
- Loading and world-entry transitions.
- Switching between major client modes.
- Wiring stage-specific UI, network behavior, and runtime managers.

## How it connects

Stage code sits above GUI and simulation. A stage can show UI, react to packets, trigger loading, and hand off to gameplay systems. If a feature changes what the player can select before entering the world, this folder is a likely checkpoint.

## New race/class relevance

For a new race/class, this folder matters for character creation and selection flow. Do not start here until the race/class representation is mapped in shared constants, server validation, data tables, and client presentation assets.