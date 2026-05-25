# DboServer

`DboServer` is the server-side service cluster. In modern backend terms, it is closer to a small distributed system than a single API server. Multiple Windows executables cooperate to authenticate players, manage characters, serve world gameplay, handle chat, and run database queries.

## Main pieces

- `Server/AuthServer/`: login/authentication-facing server.
- `Server/CharServer/`: character selection, creation, and character metadata flows.
- `Server/GameServer/`: active gameplay/world runtime.
- `Server/ChatServer/`: chat/social communication server.
- `Server/QueryServer/`: database-query support service.
- `Server/MasterServer/`: service coordination/registration layer.
- `ExecutionEnv/`: runtime folder for config files, server executables, batch launchers, and local startup orchestration.

## Higher-level analogy

A TypeScript monorepo might have packages like `auth-service`, `character-service`, `game-service`, `chat-service`, and `shared-db-client`. Here those services are separate C++ executables wired together through configs, sockets, shared libraries, and database access.

## Runtime flow, simplified

1. Master/Query infrastructure starts.
2. AuthServer accepts client login/auth traffic.
3. CharServer handles character list/create/select flows.
4. GameServer runs the actual playable channel/world.
5. ChatServer handles chat/social communication.
6. Config files in `ExecutionEnv/config` decide IPs, ports, DB credentials, table paths, and service links.

## New race/class relevance

A real new race/class touches this side heavily. Expect to inspect CharServer for creation validation and persistence, GameServer for gameplay assumptions, shared packet/data definitions, database tables, and any hard-coded race/class constants. Do not begin by editing GameServer until character creation and data representation are mapped.