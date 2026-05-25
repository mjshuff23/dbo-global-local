# DboShared

`DboShared` contains shared game/domain code and data structures that can be used across client tools, server code, trigger systems, or other project layers. This is where cross-cutting gameplay concepts tend to live when they need to be understood by more than one executable.

## Higher-level analogy

In a TypeScript monorepo, this is similar to a shared `domain` or `contracts` package. If both frontend and backend need to agree on a concept, shape, ID, table structure, trigger definition, or protocol-adjacent type, it may live here or nearby.

## Important subareas

- `DboTrigger/`: shared trigger/event logic used by tools and gameplay systems.
- Shared domain definitions and helper code that may be referenced by server/client/tool projects.

## New race/class relevance

This folder is important during research because race/class IDs, trigger behavior, table structures, or shared domain assumptions may be defined here. Before adding a new race/class, map all shared constants and data contracts first.

Agent rule: shared domain changes require client and server impact analysis. If an agent changes a shared enum/constant/struct, it must identify every consumer and every serialized/persisted representation.