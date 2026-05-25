# DboClient/Tool

This folder contains native tools and editors used to inspect, edit, package, or generate client/game content. This is the workshop wing of the codebase: table editors, world editors, model tools, GUI tools, patch tools, particle editors, trigger tools, and related utilities.

## Higher-level analogy

In a web/product system, these would be internal admin tools, migration utilities, CMS tools, asset pipeline utilities, and devtools. They may not run during normal gameplay, but they shape the data and assets the game consumes.

## Important tool categories

- Table/data tools: inspect or edit structured gameplay/client data.
- Model tools: inspect or prepare character/item/world models.
- GUI tools: inspect or edit UI layout/resource data.
- World tools: inspect or author world/map data.
- Patch/pack tools: package and distribute client resources.
- Trigger tools: inspect or author trigger/event content.

## New race/class relevance

A serious new race/class likely requires tooling research. The C++ source may only be half the story; tables, packed resources, model files, animation bindings, GUI resources, localization strings, and patch packaging may all need synchronized updates.

Agent rule: before editing tool code, first identify whether the required data can be modified with an existing tool. Tooling changes are usually second-order work, not the first move.