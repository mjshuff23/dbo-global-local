# DboClient

`DboClient` is the native game client side of the project. If `DboServer` is the backend service cluster, this folder is the desktop application, rendering/runtime shell, client-side simulation layer, GUI system, and tool ecosystem used to build or inspect client-facing assets.

For a JavaScript/TypeScript mental model, think of this as a thick desktop frontend rather than a browser app. Instead of React components and API clients, the code deals with C++ objects, message handlers, DirectX/RenderWare-era rendering concepts, local resource files, UI panels, packet generation, and client-side prediction/simulation.

## High-level folders

- `Client/`: the playable client executable and its application/game-state glue.
- `Lib/`: reusable client libraries such as core runtime utilities, GUI, simulation, presentation/rendering, movie, flasher, and framework layers.
- `Tool/`: editors and utilities for tables, GUI layouts, models, worlds, patches, particles, navigation, triggers, and other content workflows.
- `DragonBall/`: local runtime payload/config area. Large client assets and executable payloads should stay local unless intentionally tracked.

## Where to look first

Start with `Client/Stage` to understand major runtime states like login and world transitions, then `Client/Gui` to understand screens/panels, then `Lib/NtlSimulation` and `Lib/NtlPresentation` to understand how in-game entities become visible, animated, and interactive.

## Agent guardrail

Do not let an agent make broad client changes before it can explain which layer it is touching: UI, simulation, presentation/assets, packets, stage flow, or tooling. In this codebase those concerns are adjacent but not interchangeable.