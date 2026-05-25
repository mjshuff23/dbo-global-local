# DboServer/Server/GameServer

`GameServer` is the active gameplay/world runtime. Once a character enters the world, this process is responsible for the live channel experience: movement, combat-adjacent systems, world objects, NPCs, items, quests, rates, party interactions, and many server-authoritative gameplay rules.

## Responsibilities

- Run a playable world/channel.
- Handle in-world client sessions and gameplay packets.
- Coordinate with ChatServer, QueryServer, DB state, table data, and shared game definitions.
- Apply gameplay rules that should not be trusted to the client.

## Higher-level analogy

This is less like a normal CRUD API and more like a realtime game simulation backend. In TypeScript terms, imagine a websocket-heavy service with authoritative state, many event handlers, and tight coupling to shared protocol/types.

## New race/class relevance

This folder matters after the race/class can already be created and loaded. Expected touchpoints include stats, skills, transformations, equipment restrictions, movement/combat assumptions, spawn/start behavior, and any gameplay logic branching on race/class.

Agent rule: GameServer changes should come after a read-only trace from character creation to world entry. Otherwise the agent may patch symptoms while missing the actual domain source.