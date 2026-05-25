# DboClient/Lib/NtlPresentation

`NtlPresentation` is the client visual/presentation layer. It is where simulation state becomes visible: models, items, effects, transforms, render-facing data, default item visuals, and character appearance binding.

## Higher-level analogy

If `NtlSimulation` is the client-side domain store, `NtlPresentation` is closer to the rendering adapter plus component styling system. It answers questions like: given this avatar/item/state, which model, animation, effect, attachment, or transform should appear?

## What to search for

- Default item/equipment visual data.
- Link/transform lists.
- Model and effect lookup code.
- Race/gender/class visual branches.
- Costume, hair, weapon, aura, or transformation-related names.

## How it connects

Simulation says what exists. Presentation decides how it is represented visually. Tools and data tables often feed this layer, so a change here may also require asset/table edits outside the C++ source.

## New race/class relevance

This is the key client-side folder for things like Saiyan tails, hair swaps during transformations, aura changes, body proportions, equipment fit, and animation compatibility. The safest research path is to first duplicate or override existing human presentation paths before inventing a new asset pipeline.

Agent rule: separate `data-driven visual mapping` from `new rendering behavior`. Most race/class visual changes should begin as data/asset mapping experiments, not engine changes.