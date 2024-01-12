class_name InputMapping

static var default_group = "ui"

static var actions = {
	"general": {
		"pause": "pause"
	},
	"gameplay": {
		"move_up": "move_up",
		"move_down": "move_down",
		"move_left": "move_left",
		"move_right": "move_right",
		"attack": "attack"
	},
	"ui": {
		"ui_up": "ui_up",
		"ui_down": "ui_down",
		"ui_left": "ui_left",
		"ui_right": "ui_right",
		"ui_select": "ui_select"
	}
}

static var action_controls = {
	"general": {
		"key": {
			actions.general.pause: [KEY_ESCAPE]
		}
	},
	"ui": {
		"key": {
			actions.ui.ui_down: [KEY_DOWN],
			actions.ui.ui_up: [KEY_UP],
			actions.ui.ui_left: [KEY_LEFT],
			actions.ui.ui_right: [KEY_RIGHT],
			actions.ui.ui_select: [KEY_ENTER, KEY_SPACE],
		}
	},
	"gameplay": {
		"key": {
			actions.gameplay.move_down: [KEY_DOWN],
			actions.gameplay.move_up: [KEY_UP],
			actions.gameplay.move_left: [KEY_LEFT],
			actions.gameplay.move_right: [KEY_RIGHT],
			actions.gameplay.attack: [KEY_X],
		},
		"joy_button": {
			actions.gameplay.move_down: [JOY_BUTTON_DPAD_DOWN],
			actions.gameplay.move_up: [JOY_BUTTON_DPAD_UP],
			actions.gameplay.move_left: [JOY_BUTTON_DPAD_LEFT],
			actions.gameplay.move_right: [JOY_BUTTON_DPAD_RIGHT],
			actions.gameplay.attack: [],
		},
		"joy_axis": {
			actions.gameplay.move_left: [[JOY_AXIS_LEFT_X, -1.0]],
			actions.gameplay.move_right: [[JOY_AXIS_LEFT_X, 1.0]],
			actions.gameplay.move_up: [[JOY_AXIS_LEFT_Y, -1.0]],
			actions.gameplay.move_down: [[JOY_AXIS_LEFT_Y, 1.0]],
		}
	}
}
