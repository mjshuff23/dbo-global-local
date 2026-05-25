# NtlLib/Server/servercommon

`servercommon` contains shared server-side coordination and helper code. It is used by multiple server executables to avoid duplicating common server metadata/session behavior.

## What to expect

- Neighbor/server information managers.
- Shared server coordination structures.
- Common utilities used by AuthServer, MasterServer, GameServer, CharServer, ChatServer, or QueryServer.

## Higher-level analogy

This is like a shared backend package that contains service discovery metadata, common DTOs, and server coordination helpers. It is not one feature area; it supports several processes.

## Agent guardrail

Before editing, identify every server that includes or links the changed code. Shared coordination bugs can present as startup failures, connection failures, or servers not seeing each other.