extends Node

class_name State

@export var _enter_animation: String
@export var _state: State.States

enum States {
	NONE = -1,
	IDLE = 0,
	RUNNING,
	ATTACKING,
	DEAD
}

enum Action {
	MOVE = 0,
	ATTACK,
	GOT_HIT,
	DIE,
}

func get_host() -> Node2D:
	var parent = get_parent()
	
	if parent.has_method("get_host"):
		return parent.get_host() as Node2D
	else:
		return null
		
func get_state_machine() -> StateMachine:
	var parent = get_parent()
	
	if parent.has_method("get_state_machine"):
		return parent.get_state_machine() as StateMachine
	else:
		return null

func get_animation_player() -> DirectionAnimationPlayer:
	var parent = get_parent()
	
	if parent.has_method("get_animation_player"):
		return parent.get_animation_player() as AnimationPlayer
	else:
		return null

func will_enter(params = {}):
	
	pass

func will_exit():
	# tell parent
	pass

func get_state() -> int:
	return _state
	
func change_state(state: States, params = {}, push = false):
	var state_machine = get_state_machine()
	state_machine.change_state(state, params, push)

func process(delta: float):
	# move or check collision
	pass

func handle_input(event: InputEvent):
	# handle input event
	pass

func handle_action(action: State.Action, params = {}):
	# handle actions coming from the state machine
	pass

func on_animation_finished(animation: String):
	pass
