# Usage

## Setup

Needs to be set up as and Autoload.

## Creating actions and mappings


## Using actions in yout game

Use the public funcions in the `input_control.gd` node:

- `strength(action: String) -> float` to get the given action strength
- `vector(...4 actions...) => Vector2` to get the strength from these four actions in an axis-styled manner
- `pressed(action: String) -> bool` to get when an action was _just_ pressed
- `down(action: String) -> bool` to get if an action is currently being pressed down
- `released(action: String) -> bool` to get when an action was _just_ released