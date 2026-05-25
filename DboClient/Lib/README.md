# DboClient/Lib

This folder contains reusable client-side libraries. In higher-level app terms, this is the shared runtime layer under the playable client: framework utilities, GUI infrastructure, simulation, presentation/rendering, movie/flasher systems, and other client subsystems.

## Important subfolders

- `NtlCore/`: foundational utilities and base abstractions.
- `NtlFramework/`: client framework/runtime scaffolding.
- `NtlGui/`: custom GUI framework used by client screens.
- `NtlSimulation/`: client-side representation of world objects, avatars, state, packets, and gameplay-facing simulation.
- `NtlPresentation/`: visual presentation layer: models, effects, items, transforms, animations, and rendering-facing data.
- `NtlMovie/`, `NtlFlasher/`, `Discord/`: specialized integrations or media/support systems.

## Mental model

If `DboClient/Client` is the app, `DboClient/Lib` is closer to internal packages in a monorepo. The playable client depends on these libraries rather than duplicating all low-level behavior directly.

## Agent guardrail

Before changing this layer, require the agent to name whether the change is domain simulation, visual presentation, UI framework behavior, or generic runtime utility. This prevents a cosmetic idea from mutating shared infrastructure by accident.