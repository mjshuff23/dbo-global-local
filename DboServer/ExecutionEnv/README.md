# DboServer/ExecutionEnv

`ExecutionEnv` is the local runtime directory for running the server process cluster. It contains config files, startup/shutdown batch files, and expects built server executables to be present here when launching the local environment.

## What belongs here

- Server executables such as `MasterServer.exe`, `QueryServer.exe`, `AuthServer.exe`, `CharServer.exe`, `ChatServer.exe`, and `GameServer.exe`.
- `config/` files that define IPs, ports, DB credentials, table paths, channel IDs, and service-to-service endpoints.
- Batch launchers such as `start_all.bat` and `stop_all.bat` for local orchestration.

## Higher-level analogy

This folder is like a local Docker Compose/runtime directory, except it uses Windows executables and INI files instead of containers and YAML. The batch scripts are orchestration glue, not gameplay logic.

## Local Tailscale note

For remote/local testing, keep client and server endpoint config aligned:

- `DboClient/DragonBall/ConfigOptions.xml`
- `DboServer/ExecutionEnv/config/AuthServer.ini`
- related public/internal addresses in CharServer, ChatServer, GameServer, and QueryServer configs

## Agent guardrail

Config changes are operational changes. Do not mix them with gameplay/source edits unless the ticket explicitly requires both. This prevents accidental runtime breakage from being hidden inside feature work.