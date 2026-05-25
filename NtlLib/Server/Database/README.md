# NtlLib/Server/Database

This folder contains the server-side database abstraction layer. It wraps MySQL connection setup, query execution, result handling, reconnect behavior, and async query plumbing used by server processes.

## Higher-level analogy

This is not an ORM like Prisma or SQLAlchemy. It is closer to a hand-written database client package: connection pools, raw queries, result objects, async dispatch, and reconnect/error handling.

## Important concepts

- Connection lifecycle: opening, reconnecting, closing, and cleaning up MySQL handles.
- Query/result wrappers: C++ objects around database query responses.
- Async query support: running DB work away from the main service flow.
- Shared usage: multiple server processes may depend on this layer.

## Local runtime note

Recent local setup work disables MySQL SSL mode for local database connections/reconnections. That is operational compatibility work, not gameplay logic.

## Agent guardrail

Changes here need extra caution. A small DB wrapper change can affect AuthServer, CharServer, GameServer, QueryServer, and startup stability. Require agents to include validation steps and rollback notes for any edit in this folder.