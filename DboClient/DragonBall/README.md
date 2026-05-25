# DboClient/DragonBall

This folder is the local playable client payload/config area. It may contain `Client.exe`, `ConfigOptions.xml`, packed resources, localization data, and other runtime files needed to launch the game client.

## Repo policy

Large client SDKs, packed game assets, and built executable payloads should generally stay local unless there is a specific reason to track a small config/support file. Treat this folder like a local runtime mount rather than normal source code.

## Key file

- `ConfigOptions.xml`: points the client at the AuthServer endpoint. For Tailscale/local testing, keep its IP/port aligned with `DboServer/ExecutionEnv/config/AuthServer.ini`.

## New race/class relevance

This folder may eventually contain or reference the actual assets for new visuals: models, textures, animations, icons, GUI resources, and localization data. Do not commit third-party or copyrighted binary assets without an explicit decision.