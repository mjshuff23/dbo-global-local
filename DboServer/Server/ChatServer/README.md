# DboServer/Server/ChatServer

`ChatServer` handles chat and social communication flows. It is part of the runtime cluster but usually separate from core world simulation so communication can be managed independently from combat/world logic.

## Responsibilities

- Accept chat-related client/server sessions.
- Route or process chat messages.
- Maintain chat/social communication behavior.
- Coordinate with character/account data when needed.

## Higher-level analogy

This is like a websocket chat service in a full-stack app, except using the game's native packet/session protocol and C++ networking abstractions.

## New race/class relevance

Usually low direct relevance. It may matter only if race/class affects chat channels, labels, visibility, social restrictions, or character metadata shown in communication systems.