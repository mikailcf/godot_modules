extends State

# action should have the type YourStateMachine.State
@export var _state: int

func get_state() -> int:
	return _state

func will_enter(params = {}):
	#get_animation_player().play_animation(_enter_animation)
	pass

func will_exit():
	pass

func process(delta: float):
	pass

func handle_input(event: InputEvent):
	pass

# action should have the type YourStateMachine.Action
func handle_action(action, params = {}):
	pass

func on_animation_finished(animation: String):
	pass
