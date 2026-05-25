# DboServer/Server/QueryServer

`QueryServer` is the database-query support service. It centralizes or assists DB operations for the server cluster, depending on the specific flow.

## Responsibilities

- Provide query handling for account/character/game data flows.
- Coordinate with DB connection infrastructure from `NtlLib/Server/Database`.
- Support other server processes that need persistent data.

## Higher-level analogy

Think of this like a DB worker/service layer in a backend monorepo. Instead of each service owning all database behavior directly, some query work is routed through this process and shared database infrastructure.

## New race/class relevance

Moderate relevance. If race/class changes require DB schema changes, default character records, new lookup tables, or altered persistence/query behavior, inspect this service and the shared DB layer before changing runtime gameplay code.