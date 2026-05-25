# DBOGLOBAL
 DBOG Client & Server Emulator

## 3rd Party
- MySQL 5.7.18 - Required for Server
- Xtreme ToolkitPro v15.2.1 - Required for Tools
- GFx SDK 3.3 - Required for Client

## Requirements
- DirectX9 SDK
- Visual Studio 2019

# Info
 All requirements and 3rd Party can be found in our website https://forum.dboglobal.to

## Local Runtime Layout

Client SDKs, packed game assets, and built executables are local runtime inputs and must not be committed. Place the compatible playable client payload at:

```text
DboClient\DragonBall\
```

The repository ignores this payload directory while keeping its small tracked configuration/support files. The client reads `DboClient\DragonBall\ConfigOptions.xml`; keep its AuthServer endpoint aligned with `DboServer\ExecutionEnv\config\AuthServer.ini`.

For the single-channel Windows runtime, build or place server executables in `DboServer\ExecutionEnv`, then run the batch launchers directly from Windows:

```bat
.\DboServer\ExecutionEnv\start_all.bat
.\DboServer\ExecutionEnv\stop_all.bat
```

`start_all.bat -ClientDir <path>` launches an alternate client payload for testing without replacing the known-good local copy. The batch launchers do not require PowerShell.

## Codebase Learning Map

This is a native C++ client/server MMO codebase. A useful full-stack analogy is: `DboServer` is the backend service cluster, `DboClient` is the native frontend/runtime, `NtlLib` is the shared infrastructure library layer, and `DboShared` is the shared domain/protocol/data layer.

Good first reading path:

1. `DboServer/README.md` for process topology and server responsibilities.
2. `DboClient/README.md` for client runtime, simulation, UI, and presentation layers.
3. `NtlLib/README.md` for shared lower-level infrastructure.
4. `DboShared/README.md` for shared gameplay/data concepts.
5. `DboClient/Tool/README.md` for data, asset, GUI, model, world, patch, and table tooling.

The added README files are intentionally broad-level orientation docs. They are not meant to replace source-level comments. Think of them as architectural signposts for a TypeScript/Python-heavy engineer learning where the C++ dragons nest.

## Major Feature Warning: New Races or Classes

Adding a new race/class is a cross-cutting feature, not a one-file change. Treat it like adding a new domain primitive that must survive database records, packet schemas, validation rules, character creation UI, asset lookup, animations, equipment binding, localization, and server/client runtime assumptions.

A Saiyan-style race would likely require research across:

- `DboServer/Server/CharServer/` for character creation validation and persistence.
- `DboServer/Server/GameServer/` for gameplay/runtime assumptions once the character enters the world.
- `DboClient/Client/Gui/` and `DboClient/Client/Stage/` for creation/login/client UX.
- `DboClient/Lib/NtlSimulation/` for client-side avatar/entity simulation.
- `DboClient/Lib/NtlPresentation/` for model, item, transform, animation, effect, and visual binding.
- `DboClient/Tool/` for table/model/asset/editor workflows.
- `DboShared/` and `NtlLib/` for shared types, packet contracts, trigger logic, and infrastructure assumptions.

The safe agent workflow is: map current race/class IDs first, build an evidence table of every source/table/asset dependency, make a tiny cosmetic prototype, then expand into server validation and persistence. Do not prompt an agent to “add Saiyans” in one pass. That is how a codebase turns into confetti with stack traces.
