extends Control

var _actions = {
	"general": {
		"pause": "pause"
	},
	"character": {
		"move_up": "move_up",
		"move_down": "move_down",
		"move_left": "move_left",
		"move_right": "move_right"
	},
	"ui": {
		"ui_up": "ui_up",
		"ui_down": "ui_down",
		"ui_select": "ui_select"
	}
}

var _key_mapping = {
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
			_actions.character.move_right: [KEY_RIGHT]
		},
		"joy_button": {
			_actions.character.move_down: [JOY_DPAD_DOWN],
			_actions.character.move_up: [JOY_DPAD_UP],
			_actions.character.move_left: [JOY_DPAD_LEFT],
			_actions.character.move_right: [JOY_DPAD_RIGHT],
		},
		"joy_axis": {
			_actions.character.move_left: [[JOY_AXIS_0, -1.0]],
			_actions.character.move_right: [[JOY_AXIS_0, 1.0]],
			_actions.character.move_up: [[JOY_AXIS_1, -1.0]],
			_actions.character.move_down: [[JOY_AXIS_1, 1.0]],
		}
	}
}

var _current_mapping = {}
var _general_mapping = _key_mapping.general
var _current_context = "character"
var _pressing = {}
var _connected_joypads = {}
var _deadzone = 0.1

func _init() -> void:
	_current_mapping = _key_mapping[_current_context]

	for group in _actions.keys():
		for action in _actions[group].keys():
			if not InputMap.has_action(action):
				InputMap.add_action(action)

func  _ready():
	Input.connect(
		"joy_connection_changed",
		self,
		"_on_joy_connection_changed"
	)

	for joypad in Input.get_connected_joypads():
		_connected_joypads[joypad] = true
	
	_add_inputs()
		
func _on_joy_connection_changed(device_id, connected):
	_connected_joypads[device_id] = connected

func _add_inputs():
	for context in _key_mapping.keys():
		var key_actions = _key_mapping[context].get("key", {})

		for action in key_actions.keys():
			var action_keys = key_actions[action]

			if not InputMap.has_action(action):
				InputMap.add_action(action)

			for key in action_keys:
				var ev = InputEventKey.new()
				ev.scancode = key
				InputMap.action_add_event(action, ev)
		
		var joy_button_actions = _key_mapping[context]\
			.get("joy_button", {})

		for action in joy_button_actions.keys():
			var action_buttons = joy_button_actions[action]

			if not InputMap.has_action(action):
				InputMap.add_action(action)

			for button in action_buttons:
				var ev = InputEventJoypadButton.new()
				ev.button_index = button
				InputMap.action_add_event(action, ev)


		var joy_axis_actions = _key_mapping[context]\
			.get("joy_axis", {})

		for action in joy_axis_actions.keys():
			var action_axis = joy_axis_actions[action]

			if not InputMap.has_action(action):
				InputMap.add_action(action)

			for axis_tuple in action_axis:
				var ev = InputEventJoypadMotion.new()
				ev.axis = axis_tuple[0]
				ev.axis_value = axis_tuple[1]
				InputMap.action_add_event(action, ev)


func _change_context():
	if _current_context == "character":
		_current_context = "ui"
	else:
		_current_context = "character"
	
	_current_mapping = _key_mapping[_current_context]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_change_context()

	# if not _current_context == "ui":
	# 	for action in _actions.ui.keys():
	# 		if event.is_action_pressed(action):
	# 			accept_event()
