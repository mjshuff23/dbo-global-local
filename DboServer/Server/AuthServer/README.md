# DboServer/Server/AuthServer

`AuthServer` handles the authentication/login-facing side of the server cluster. It is one of the first server processes the client talks to when entering the game.

## Responsibilities

- Accept client login/auth sessions.
- Validate account-facing requests.
- Communicate with MasterServer and/or neighboring server managers.
- Hand the client toward later character/game server flow after authentication succeeds.

## Files to inspect

- `AuthServer.cpp/.h`: service startup, initialization, and main server behavior.
- `ClientSession.*`: client connection/session behavior.
- `MasterServerSession.*`: communication with the master/coordinator process.
- `PacketAuthServer.cpp`: auth packet handling.
- `MasterServerPacket.cpp`: master-server packet handling.
- `SubNeighborServerInfoManager.*`: neighboring service/server metadata.

## Higher-level analogy

This is the native C++ equivalent of an auth microservice plus websocket/session handling. Instead of REST controllers and JWT middleware, it uses custom packets, sessions, and database/config-driven server state.

## New race/class relevance

Usually low direct relevance. Auth may need no changes for a new race/class unless login payloads, account entitlements, or server routing become race/class-aware. Character creation and gameplay logic are more likely to live in CharServer/GameServer.