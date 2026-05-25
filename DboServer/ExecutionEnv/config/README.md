# DboServer/ExecutionEnv/config

This folder contains INI configuration files for the server executables. These files wire the service cluster together: addresses, public addresses, ports, database credentials, table/resource paths, connection limits, and channel behavior.

## What to inspect

- `AuthServer.ini`: client login/auth endpoint and account DB settings.
- `CharServer.ini`: character service address, account/character DB access, table paths.
- `ChatServer.ini`: chat service address, DB access, table path, server accept settings.
- `GameServer.ini`: world/channel address, DB access, chat linkage, query linkage, gameplay rates.
- `QueryServer.ini`: DB query service configuration.

## Higher-level analogy

These are like `.env` files plus service config files. They are not just passive settings; wrong values can prevent servers from discovering each other or clients from connecting.

## Agent guardrail

Never let an agent casually change IPs, public addresses, DB users, ports, or table paths while working on unrelated gameplay logic. Config changes should be isolated and tested with startup/shutdown scripts.