# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A collection of decoupled, modular GDScript components for Godot 4. All modules are pure GDScript (no C++). Used as a git submodule in game projects:

```bash
git submodule add https://github.com/mikailcf/godot_modules modules
```

## Module Overview

### Behavior Tree (`behavior_tree/`)

Hierarchical AI using the classic behavior tree pattern. The `BehaviorTree` root node ticks the tree each frame and passes a shared `Blackboard` to all nodes.

**Node types:**
- **Leaf nodes:** `BehaviorTreeAction` (override `_do_action()`) and `BehaviorTreeWait`
- **Composites:** `BehaviorTreeSequence` (AND logic), `BehaviorTreeFallback` (OR logic), `BehaviorTreeParallel` (all children run)
- **Decorators:** `BehaviorTreeCondition` (override `_check_condition()`), `BehaviorTreeInverter`, `BehaviorTreeSucceeder`, `BehaviorTreeFailer`, `BehaviorTreeInterrupt`

All nodes return `SUCCESS`, `FAILURE`, or `RUNNING`. Running nodes get a visual "X  " prefix in the scene tree for debugging.

Key files:
- [behavior_tree/public/behavior_tree.gd](behavior_tree/public/behavior_tree.gd) — root tick controller
- [behavior_tree/internal/behavior_tree_node.gd](behavior_tree/internal/behavior_tree_node.gd) — base class with template methods
- [behavior_tree/public/blackboard.gd](behavior_tree/public/blackboard.gd) — shared dictionary state with scoped access

### State Machine (`state_machine/`)

Stack-based state machine with animation integration. States live as children of `StateMachine` in the scene tree.

`StateMachine` requires: `_host` (controlled entity), `_animation_player` (`DirectionAnimationPlayer`), and `initial_state_val`.

States extend `State` and override lifecycle methods: `will_enter(params)`, `will_exit()`, `process(delta)`, `handle_input(event)`, `handle_action(action, params)`, `on_animation_finished(animation_name)`.

States transition via `change_state()` or `pop_state()` (returns to previous stacked state).

Key files:
- [state_machine/state_machine.gd](state_machine/state_machine.gd)
- [state_machine/state.gd](state_machine/state.gd)
- [state_machine/direction_animation_player.gd](state_machine/direction_animation_player.gd)

### Animation (`animation/`)

`Interpol` is a standalone (non-Node) class for manual property interpolation. Uses a builder API with track-based sequencing: same track = sequential, different tracks = parallel.

```gdscript
interpolation.interpolate_property(node, "position", target, duration, track=0)
interpolation.play()
# call interpolation.advance(delta) in _process()
```

Key file: [animation/interpol.gd](animation/interpol.gd)

### Core (`core/`)

Six infrastructure sub-modules, most intended as autoloads:

| Sub-module | Type | Purpose |
|---|---|---|
| `event_bus` | Autoload | Global events via `generic_event(event_type, payload)` signal |
| `game_root` | Scene root | Initialization, ESC pause, quit handling |
| `scene_loader` | Manager node | Fade-transition scene changes with push/pop stack |
| `input_control` | Autoload | Context-based input mapping (gameplay vs UI) |
| `storage` | Static utility | Save/load: compressed JSON for game data, CFG for options |
| `menu` | UI nodes | Main menu management |

`InputControl` wraps Godot input with `strength()`, `vector()`, `pressed()`, `down()`, `released()`. Edit `InputMapping` to configure actions.

`SceneLoader` methods: `change_to_scene(path, animated)`, `push_scene(path, animated)`, `pop_scene(animated)`.

### 3D (`3d/`)

`CameraPivot` — a `@tool` isometric follow camera using lerp-based smooth following. Configure target node and distance in Inspector.

Key file: [3d/isometric_camera/camera_pivot.gd](3d/isometric_camera/camera_pivot.gd)

## Architecture Patterns

- **Template methods:** Override `_do_action()`, `_check_condition()`, `will_enter()`, etc. Never call the base implementations directly.
- **Autoloads:** EventBus and InputControl are global singletons; Storage is a static class.
- **Scene composition:** Behavior trees and state machines are built entirely in the Godot scene tree — add child nodes to compose behavior.
- **Blackboard:** The behavior tree's shared state dictionary; use `set_value()` / `get_value()` with a scope key.
