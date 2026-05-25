# DboServer/Server/CharServer

`CharServer` handles character-facing account flows after authentication and before entering the active world. This is one of the highest-value folders for understanding character creation, character selection, and race/class validation.

## Responsibilities

- Load and return character lists.
- Create/delete/select characters.
- Validate character metadata such as race, class, gender, appearance, names, and starting conditions.
- Communicate with account/character databases.
- Coordinate handoff toward GameServer/world entry.

## Files to inspect

- `CharServer.cpp/.h`: service startup and initialization.
- `PacketCharServer.cpp`: validates `sUC_CHARACTER_ADD_REQ`, race/class combinations, and newbie-table-backed character creation before forwarding it.
- `ClientSession.*`: client-facing connection and packet dispatch.
- `QueryServerPacket.cpp` and `QueryServerSession.*`: persistence request/response flow with QueryServer.
- `DboShared/NtlShared2/NtlPacketUC.h` and `NtlPacketCQ.h`: shared client-to-character and character-to-query packet contracts.

## Higher-level analogy

This is like a `characters-service` in a NestJS monorepo. It validates input, reads/writes character data, and prepares data for the next service. Because this is an MMO server, the contract is packet/session based rather than HTTP/JSON.

## New race/class relevance

This is a primary folder for new race/class work. Before implementation, map every existing race/class validation branch, starting location, appearance constraint, default item, default skill, and database field touched during character creation.

Agent rule: do not let an agent add a race/class here until it can produce a table of existing allowed values and the corresponding client/shared constants.
