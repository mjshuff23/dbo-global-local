# DboShared/DboTrigger

`DboTrigger` contains shared trigger/event-system code. Trigger systems usually encode content logic: conditions, actions, scripted events, quests, world interactions, or other data-driven behavior.

## Higher-level analogy

This is similar to a rules engine or workflow engine in a backend app. Instead of hard-coding every event in imperative service code, parts of the game can use trigger definitions interpreted by shared logic and tools.

## How it connects

- Tools may create or inspect trigger data.
- Client/server systems may consume trigger definitions at runtime.
- Quest/world/content behavior may depend on trigger data and code.

## New race/class relevance

Potentially relevant if race/class changes affect quests, starting areas, tutorial events, transformation events, or race-specific content. Research existing trigger usage before adding special-case gameplay code.