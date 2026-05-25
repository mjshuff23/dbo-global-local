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
