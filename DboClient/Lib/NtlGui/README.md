# DboClient/Lib/NtlGui

`NtlGui` is the custom GUI framework used by the native client. It is the low-level UI toolkit under `DboClient/Client/Gui`.

## Higher-level analogy

Think of this less like React components and more like the rendering/event/widget foundation that React would sit on top of. The game has its own GUI controls, layout behavior, event dispatch, rendering hooks, and resource binding.

## How it connects

- `DboClient/Client/Gui` uses this layer to build concrete screens.
- UI resources and layout definitions may be created or edited with tools under `DboClient/Tool`.
- GUI events often bridge into packet generation, local simulation, or stage transitions.

## When to touch this folder

Only change this layer if the UI framework itself needs new behavior. For feature work, prefer changing the concrete GUI screen first. Editing the framework for a single screen is like changing Express or React internals to fix one route. Possible, but usually a bad smell.