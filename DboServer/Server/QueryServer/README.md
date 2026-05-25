# DboServer/Server/QueryServer

`QueryServer` is the database-query support service. It centralizes or assists DB operations for the server cluster, depending on the specific flow.

## Responsibilities

- Provide query handling for account/character/game data flows.
- Coordinate with DB connection infrastructure from `NtlLib/Server/Database`.
- Support other server processes that need persistent data.

## Files to inspect

- `QueryServer.cpp/.h`: application startup, database initialization, query worker startup, and main service behavior.
- `CharServerSession.*` and `CharPacket.cpp`: requests arriving from CharServer, including character creation persistence.
- `GameServerSession.*` and `GamePacket.cpp`: the large set of in-world persistence requests routed from GameServer.
- `ChatServerSession.*` and `ChatPacket.cpp`: persistence-related social/chat service requests.
- `CharacterManager.*`, `PlayerCache.*`, and `ItemManager.*`: cached character and item-facing state.
- `DatabaseTaskRun.*` and `GameDatabase.cpp`: asynchronous/queued database processing.
- `NtlLib/Server/Database/`: shared MySQL connection and query wrapper code used beneath this service.

## Higher-level analogy

Think of this like a DB worker/service layer in a backend monorepo. Instead of each service owning all database behavior directly, some query work is routed through this process and shared database infrastructure.

## New race/class relevance

Moderate relevance. If race/class changes require DB schema changes, default character records, new lookup tables, or altered persistence/query behavior, inspect this service and the shared DB layer before changing runtime gameplay code.
