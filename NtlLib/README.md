# NtlLib

`NtlLib` contains shared native libraries used across the client, server, or both. This is infrastructure territory: database wrappers, threading, logging, networking/session helpers, math/core utilities, server common code, and other foundational systems.

## Higher-level analogy

In a TypeScript monorepo, this would be a set of shared packages like `@repo/core`, `@repo/db`, `@repo/network`, `@repo/logger`, and `@repo/server-common`. The C++ version is more tightly coupled to Visual Studio projects, headers, static libraries, and native linking.

## Important areas

- `Server/Database/`: MySQL connection/query abstraction used by server processes.
- `Server/servercommon/`: shared server-side coordination/session/helper code.
- `Server/NtlThread/`: threading primitives and worker abstractions.
- `Server/NtlSfx/`: server-side support library pieces.

## How it connects

Server executables depend on this layer for common behavior. A change here can affect multiple services at once, so treat it like changing a shared npm package used across every backend app.

## Agent guardrail

Require a blast-radius note for any change under `NtlLib`: which services link this code, what runtime path uses it, and how to validate it. Shared native changes can look small but behave like infrastructure migrations.