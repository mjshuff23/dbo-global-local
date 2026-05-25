# DboClient/Client

This folder contains the main playable client project. It is the native C++ equivalent of the app shell in a web project: startup, global managers, game states, UI entry points, packet interaction, and feature-specific client handlers live here.

## Conceptual map

- `Stage/`: high-level application states such as login, character selection, loading, and world entry. In web terms, these are closer to route-level state machines than simple pages.
- `Gui/`: interactive UI panels, dialogs, HUD pieces, inventory windows, auction house screens, quest panels, and other client interface code.
- Feature handlers such as `MrPoPoHandler.cpp`: client-side coordination for specific gameplay or system features.
- Project files such as `Client.vcxproj`: Visual Studio build configuration, roughly comparable to package/build metadata plus compile/link instructions.

## How it connects

The client receives server packets, updates local simulation objects, shows GUI changes, and sends requests back through packet generators/session layers. Unlike a browser frontend, this client owns rendering, UI widgets, local files, animation state, and some gameplay presentation logic directly.

## Learning route

1. Read `Stage/` first to understand how the client moves from login to playable world.
2. Read `Gui/` next to see how user-facing flows are implemented.
3. Follow packet calls from a UI action into the simulation/network layer.
4. Follow visual updates from simulation state into presentation/model/effect code.

## New race/class relevance

Character creation, character selection, login flow, and UI display assumptions are likely to pass through this folder. For a Saiyan-style prototype, this is where you would eventually need the client to expose/select/display the race, but not where you should start blindly. First map existing race/class IDs and data tables.