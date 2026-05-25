# DboServer/Server

This folder contains the source for the major server executables. Each subfolder is effectively a backend service process with its own Visual Studio project, sessions, packet handlers, and service-specific logic.

## Service folders

- `MasterServer/`: coordinates server/service registration and neighbor server information.
- `QueryServer/`: centralizes or supports database query flows.
- `AuthServer/`: handles login/authentication-facing client sessions.
- `CharServer/`: handles character list, creation, deletion, selection, and related validation.
- `GameServer/`: handles the active world/channel runtime.
- `ChatServer/`: handles chat/social communication flows.

## Higher-level analogy

Imagine a NestJS monorepo with several apps under `apps/`: `auth`, `characters`, `game`, `chat`, `query`, and `master`. The difference is that these are C++ executables, not Node services, and they communicate through custom packet/session code rather than HTTP/GraphQL.

## How to read a service

1. Find the service main class, e.g. `AuthServer`, `CharServer`, or `GameServer`.
2. Find session classes, usually representing connected clients or neighboring services.
3. Find packet handler/generator files.
4. Find config loading and DB/table initialization.
5. Trace one request end-to-end before changing anything.

## Agent guardrail

For server work, require agents to identify the packet/session boundary they are changing. A server-side bug may involve protocol data, DB state, table data, or client assumptions, not just one C++ function.