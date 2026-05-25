# DboClient/Client/Gui

This folder contains client-side GUI screens and widgets. In a TypeScript app, this would feel like a huge folder of React/Vue/Svelte components plus event handlers, except everything is native C++ and wired into the game's custom GUI framework.

## What belongs here

- HUD panels and gameplay windows.
- Inventory, quest, auction, scouter, dialog, and menu interfaces.
- Button/input event handling.
- UI-to-packet bridges where a click eventually sends a request to the server.
- UI updates driven by simulation/game state.

## How to read these files

Look for lifecycle-like methods: create/load, destroy/unload, show/hide, handle event, update, and packet/state response handlers. The naming will not be as uniform as a modern frontend framework, so search by feature nouns: `Auction`, `Quest`, `Inventory`, `Scouter`, `Skill`, `Char`, `Party`, etc.

## New race/class relevance

For a new race/class, this folder likely needs changes only after the domain/data work is understood. Expected UI surfaces include character creation, character selection, race/class labels, icons, tooltips, preview model selection, and possibly transformation/state indicators.

Agent rule: UI changes should not invent race IDs or data contracts. They should consume already-defined constants/tables from shared/client data layers.