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

## Start Here

These documents are intended as an onboarding map for developers learning this
native C++ client/server codebase:

| Reading order | Document | Purpose |
| --- | --- | --- |
| 1 | [Learning C++ Through DBOGLOBAL](docs/CPP_LEARNING_PATH.md) | Relate native C++ concepts to TypeScript/Python experience and trace one real feature. |
| 2 | [Server overview](DboServer/README.md) | Understand the six-process runtime and service responsibilities. |
| 3 | [Client overview](DboClient/README.md) | Understand UI, stages, simulation, presentation, tools, and the playable payload. |
| 4 | [Shared infrastructure](NtlLib/README.md) and [shared game/domain code](DboShared/README.md) | Understand code used across processes and cross-cutting data contracts. |
| 5 | [Researching a New Race or Transformation](docs/NEW_RACE_RESEARCH.md) | Follow confirmed source anchors for a major feature without jumping to unsafe edits. |
| 6 | [Client tooling overview](DboClient/Tool/README.md) | Explore table, asset, world, GUI, and packaging tooling once the runtime map is clear. |

## Local Runtime Layout

Client SDKs, packed game assets, and built executables are local runtime inputs
and must not be committed. Place the compatible playable client payload at:

```text
DboClient\DragonBall\
```

The repository ignores this payload directory while keeping its small tracked
configuration/support files. The client reads
`DboClient\DragonBall\ConfigOptions.xml`; keep its AuthServer endpoint aligned
with `DboServer\ExecutionEnv\config\AuthServer.ini`.

For the single-channel Windows runtime, build or place server executables in
`DboServer\ExecutionEnv`, then run the batch launchers directly from Windows:

```bat
.\DboServer\ExecutionEnv\start_all.bat
.\DboServer\ExecutionEnv\stop_all.bat
```

`start_all.bat -ClientDir <path>` launches an alternate client payload for
testing without replacing the known-good local copy. The batch launchers do not
require PowerShell.

## Codebase Learning Map

This is a native C++ client/server MMO codebase. A useful full-stack analogy is:
`DboServer` is the backend service cluster, `DboClient` is the native
frontend/runtime, `NtlLib` is the shared infrastructure library layer, and
`DboShared` is the shared domain/protocol/data layer.

The folder READMEs are intentionally broad-level orientation docs. They are not
meant to replace tracing actual source or validating a feature-specific hypothesis.

## Major Feature Warning: New Races or Classes

Adding a new race/class is a cross-cutting feature, not a one-file change. Treat
it like adding a new domain primitive that must survive database records, packet
schemas, validation rules, character creation UI, asset lookup, animations,
equipment binding, localization, and server/client runtime assumptions.

The code already contains a Super Saiyan aspect state for existing characters;
that is not the same as a new playable race. See
[Researching a New Race or Transformation](docs/NEW_RACE_RESEARCH.md) for
confirmed source anchors, lower-risk experiments, and an evidence-first workflow.
