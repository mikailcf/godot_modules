# needs to be autoloaded
extends Control

var _actions = {
	"general": {
		"pause": "pause"
	},
	"character": {
		"move_up": "move_up",
		"move_down": "move_down",
		"move_left": "move_left",
		"move_right": "move_right",
		"attack": "attack"
	},
	"ui": {
		"ui_up": "ui_up",
		"ui_down": "ui_down",
		"ui_select": "ui_select"
	}
}

var _control_mapping = {
	"general": {
		"key": {
			_actions.general.pause: [KEY_ESCAPE]
		}
	},
	"ui": {
		"key": {
			_actions.ui.ui_down: [KEY_DOWN],
			_actions.ui.ui_up: [KEY_UP],
			_actions.ui.ui_select: [KEY_ENTER],
		}
	},
	"character": {
		"key": {
			_actions.character.move_down: [KEY_DOWN],
			_actions.character.move_up: [KEY_UP],
			_actions.character.move_left: [KEY_LEFT],
			_actions.character.move_right: [KEY_RIGHT],
			_actions.character.attack: [KEY_X],
		},
		"joy_button": {
			_actions.character.move_down: [JOY_DPAD_DOWN],
			_actions.character.move_up: [JOY_DPAD_UP],
			_actions.character.move_left: [JOY_DPAD_LEFT],
			_actions.character.move_right: [JOY_DPAD_RIGHT],
			_actions.character.attack: [JOY_SONY_X],
		},
		"joy_axis": {
			_actions.character.move_left: [[JOY_AXIS_0, -1.0]],
			_actions.character.move_right: [[JOY_AXIS_0, 1.0]],
			_actions.character.move_up: [[JOY_AXIS_1, -1.0]],
			_actions.character.move_down: [[JOY_AXIS_1, 1.0]],
		}
	}
}

var _current_actions = []
var _general_mapping = _control_mapping.general
var _current_context = "character"
var _connected_joypads = {}

func _init() -> void:
	_update_current_actions()

	for group in _actions.keys():
		for action in _actions[group].keys():
			if not InputMap.has_action(action):
				InputMap.add_action(action)

func _ready():
	Input.connect(
		"joy_connection_changed",
		self,
		"_on_joy_connection_changed"
	)

	for joypad in Input.get_connected_joypads():
		_connected_joypads[joypad] = true
	
	_add_inputs()

func _update_current_actions():
	var mapping = _actions[_current_context]
	_current_actions = mapping.keys()

func _on_joy_connection_changed(device_id, connected):
	_connected_joypads[device_id] = connected

func _event_for_input(input_type: String, input):
	var event

	match input_type:
		"key":
			event = InputEventKey.new()
			event.scancode = input
		"joy_button":
			event = InputEventJoypadButton.new()
			event.button_index = input
		"joy_axis":
			event = InputEventJoypadMotion.new()
			event.axis = input[0]
			event.axis_value = input[1]

	return event

func _add_inputs():
	for context in _control_mapping.keys():
		var mapping = _control_mapping[context]

		for input_type in ["key", "joy_button", "joy_axis"]:
			var input_actions = mapping.get(input_type, {})

			for action in input_actions.keys():
				var action_inputs = input_actions[action]
	
				if not InputMap.has_action(action):
					InputMap.add_action(action)
	
				for input in action_inputs:
					var ev = _event_for_input(input_type, input)
					InputMap.action_add_event(action, ev)

func _change_context():
	if _current_context == "character":
		_current_context = "ui"
	else:
		_current_context = "character"
	
	_update_current_actions()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_change_context()

	if not _current_context == "ui":
		for action in _actions.ui.keys():
			if event.is_action_pressed(action):
				accept_event()

func _in_current_context(actions: Array):
	for action in actions:
		if not _current_actions.has(action):
			return false
	
	return true

func strength(action: String) -> float:
	if not _in_current_context([action]):
		return 0.0

	return Input.get_action_strength(action)

func vector(
	hor_neg: String,
	hor_pos: String,
	vert_neg: String,
	vert_pos: String,
	deadzone: float = -1.0) -> Vector2:

	var actions = [hor_neg, hor_pos, vert_neg, vert_pos]
	if not _in_current_context(actions):
		return Vector2()

	return Input.get_vector(
		hor_neg,
		hor_pos,
		vert_neg,
		vert_pos,
		deadzone
	)

func pressed(action: String) -> bool:
	if not _in_current_context([action]):
		return false
	
	return Input.is_action_just_pressed(action)

func down(action: String) -> bool:
	if not _in_current_context([action]):
		return false
	
	return Input.is_action_pressed(action)

func released(action: String) -> bool:
	if not _in_current_context([action]):
		return false
	
	return Input.is_action_just_released(action)