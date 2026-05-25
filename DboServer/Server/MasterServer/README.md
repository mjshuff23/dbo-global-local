# DboServer/Server/MasterServer

`MasterServer` is the coordination process for the server cluster. It tracks or exchanges neighbor/server information so the other services can discover and coordinate with each other.

## Responsibilities

- Coordinate service registration or neighbor server metadata.
- Communicate with AuthServer and other server processes.
- Provide central cluster-level state needed during startup/runtime.

## Files to inspect

- `MasterServer.cpp/.h`: service startup and main behavior.
- `AuthSession.*`: communication with AuthServer.
- `AuthPacket.cpp`: auth-facing packet handling from the master side.
- `SessionFactory.*`: session creation wiring.
- `SubNeighborServerInfoManager.*`: service/neighbor metadata.

## Higher-level analogy

This is roughly a lightweight service registry/coordinator. It is not Kubernetes, but conceptually it helps the cluster know who exists and where to talk.

## New race/class relevance

Usually low direct relevance unless new race/class work changes service routing, startup table loading, or server metadata assumptions. Most race/class work should start in CharServer/shared data/client presentation instead.