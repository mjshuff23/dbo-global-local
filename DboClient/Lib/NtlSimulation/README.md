# DboClient/Lib/NtlSimulation

`NtlSimulation` is the client-side gameplay/world simulation layer. It is where the client represents things that exist in the game world: avatar-like objects, NPCs, items, community state, packet generation, world concepts, and other runtime entities.

## Higher-level analogy

In a TypeScript app, this would be part domain model, part client-side store, part API adapter, and part realtime state machine. The difference is that here the state is native C++ and directly feeds the renderer/presentation layer and game loop.

## Common concepts

- `Sob` classes: simulation objects, roughly "things in the world".
- Factory classes: create simulation objects or attributes from IDs/data.
- Packet generator classes: client request builders that talk to the server.
- World concept classes: special gameplay contexts such as ranked battle, time machine quest, scramble, free-PVP, etc.
- Community/agent classes: social and server-facing client state.

## How it connects

`NtlSimulation` consumes server packets and table data, maintains local object state, and informs the presentation layer what should be visible or updated. Presentation code decides how something looks; simulation code decides what the client thinks exists and what state it is in.

## New race/class relevance

This is one of the most important client folders for new race/class work. You would inspect avatar classes, object factories, attribute factories, packet generators, and any race/class branching. A cosmetic-only prototype might avoid deep changes here, but a real playable race/class will not.