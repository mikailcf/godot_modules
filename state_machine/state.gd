extends Node

class_name State

@export var _enter_animation: String

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
	
func change_state(state: Variant, params = {}, push = false):
	var state_machine = get_state_machine()
	state_machine.change_state(state, params, push)
	
func get_state() -> int:
	return -1

func will_enter(_params = {}):
	pass

func will_exit():
	pass

func process(_delta: float):
	# move or check collision
	pass

func handle_input(_event: InputEvent):
	# handle input event
	pass

func handle_action(_action, _params = {}):
	# handle actions coming from the state machine
	pass

func on_animation_finished(_animation: String):
	pass
