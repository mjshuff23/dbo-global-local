# NtlLib/Server

This folder contains shared server-side libraries used by the server executables. It is the infrastructure layer beneath `DboServer/Server/*`.

## Key subfolders

- `Database/`: MySQL wrapper, query results, async query support, and DB connection lifecycle.
- `servercommon/`: common server/session/neighbor metadata utilities.
- `NtlThread/`: threading helpers and abstractions.
- `NtlSfx/`: shared server support code.

## Higher-level analogy

This is the backend platform package layer. In a NestJS system, this would include shared DB modules, worker helpers, common service contracts, and infrastructure utilities imported by multiple apps.

## New race/class relevance

Usually indirect. Race/class feature work may pass through here only if persistence/query behavior, shared server metadata, or threading/async behavior needs support. Most feature-specific logic belongs in service folders or shared game/domain definitions, not this infrastructure layer.