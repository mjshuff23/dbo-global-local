# NtlLib/Server/NtlThread

`NtlThread` contains shared threading support for the server side. Native C++ server code often uses explicit thread primitives and worker loops where a higher-level TypeScript/Python stack might hide concurrency behind promises, async/await, workers, queues, or framework internals.

## What to expect

- Thread lifecycle helpers.
- Worker/task abstractions.
- Synchronization-sensitive code.
- Support code used by async database work or long-running server loops.

## Higher-level analogy

This is closer to Node worker threads, Python threading/async workers, or a custom job runner, but with less runtime safety net. Native threading bugs can become deadlocks, races, crashes, or subtle state corruption.

## Agent guardrail

Do not let an agent alter threading behavior unless the ticket is specifically about concurrency/runtime stability. Require before/after reasoning about ownership, lifetime, shared state, and shutdown behavior.