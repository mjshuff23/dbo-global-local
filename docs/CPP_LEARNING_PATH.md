# Learning C++ Through DBOGLOBAL

This guide is for a developer who is comfortable in TypeScript, JavaScript, or Python and wants to learn native C++ by tracing a working game rather than reading language features in isolation.

## First Mental Model

DBOGLOBAL is a Visual Studio C++ system with several executables and static/shared libraries:

| C++ concept in this repository | Higher-level comparison | Where to see it |
| --- | --- | --- |
| `.h` headers plus `.cpp` implementations | exported types/interfaces plus implementation modules | `DboShared/NtlShared2/NtlCharacter.h`, `DboShared/NtlShared2/NtlCharacter.cpp` |
| `.vcxproj` projects and `.sln` solutions | package/build configuration and a monorepo workspace | `DboClient/Client/Client.vcxproj`, `DboServer/DboServer.sln` |
| enums and packed structs | shared TypeScript DTOs/enums, except binary protocol layout matters | `DboShared/NtlShared2/NtlCharacter.h`, `DboShared/NtlShared2/NtlPacketUC.h` |
| sessions and packet handlers | websocket handlers or event consumers | `DboServer/Server/CharServer/ClientSession.cpp`, `PacketCharServer.cpp` |
| tables loaded from resources | seed/config/catalog data consumed at runtime | `DboShared/NtlGameTable/PCTable.*`, `NewbieTable.*` |
| simulation versus presentation | state/store versus renderer/view adapter | `DboClient/Lib/NtlSimulation/`, `DboClient/Lib/NtlPresentation/` |

## C++ Ideas To Learn In This Codebase

### Headers, compilation, and linking

Start with a small pair such as `DboShared/NtlShared2/NtlCharacter.h` and `.cpp`. A header declares types and functions that other projects compile against; a `.cpp` provides compiled behavior. A linker later connects references across libraries and executables.

In TypeScript terms, a header looks somewhat like exported type/function declarations, but it is part of the compiler contract and can affect memory layout and binary compatibility. Editing a shared packet struct is not like adding an optional JSON property: client and server must agree on the exact representation.

### Values, pointers, references, and lifetime

C++ code here commonly passes raw pointers such as `CNtlPacket*` and uses explicit creation/destruction. A pointer may mean “this object exists elsewhere; do not copy it,” but the type alone often does not tell you who owns it or how long it remains valid.

When changing pointer-heavy code, ask:

1. Who created the object?
2. Who destroys it?
3. Can this pointer be null?
4. Can another object outlive the data it refers to?
5. Does the same state exist for multiple players at once?

That last question is why visual work should prefer per-instance owner state over global mutable pointers.

### Enums and array-index contracts

`eRACE` and `ePC_CLASS` in `DboShared/NtlShared2/NtlCharacter.h` are not merely labels. Code sizes arrays using `RACE_COUNT` and `PC_CLASS_COUNT`, including the PC and newbie tables. Adding an enum member can change indexing assumptions across client, server, tools, and loaded data.

Treat these enums like a database enum, protocol enum, and array schema combined.

### Packets and server boundaries

Follow character creation as a first end-to-end exercise:

1. The client builds `sUC_CHARACTER_ADD_REQ` in `DboClient/Client/Main/DboPacketGenerator.cpp`.
2. The request shape is declared in `DboShared/NtlShared2/NtlPacketUC.h`.
3. CharServer validates it in `DboServer/Server/CharServer/PacketCharServer.cpp`.
4. CharServer forwards persistence work using `sCQ_CHARACTER_ADD_REQ`.
5. QueryServer handles the database-facing work in `DboServer/Server/QueryServer/CharPacket.cpp`.
6. The client receives the result through its lobby packet handling.

This is the native equivalent of tracing a frontend form through an API contract, service validation, repository write, and response handler.

### Data-driven behavior

Not every feature belongs in C++ logic. `PCTable` and `NewbieTable` select initial/player data using race and class. The executable may implement the rule, while RDF/table or packed asset data provides the values and visuals. Before patching code, determine whether a desired change is really a table or asset change.

## Reading Route

1. Read [the root overview](../README.md) and [server topology](../DboServer/README.md).
2. Trace one server request using `CharServer` and `QueryServer`.
3. Read [client orientation](../DboClient/README.md), then follow character creation UI into packet generation.
4. Read [simulation](../DboClient/Lib/NtlSimulation/README.md) and [presentation](../DboClient/Lib/NtlPresentation/README.md) before touching in-world visuals.
5. Read [new race research](NEW_RACE_RESEARCH.md) as an example of mapping a large feature before implementation.

## Safe Agent Workflow

For any agent-authored C++ change, require:

1. Exact source files and symbols it intends to modify.
2. A statement of whether the behavior is protocol, persistence, table/data, simulation, presentation, or UI.
3. A build target and test scenario.
4. A fallback/rollback path for client assets or runtime configuration.
5. A review for pointer lifetime, shared mutable state, enum/range checks, and client/server contract changes.

Small, observable slices are the best learning path: compile, run, observe, then expand.
