class_name StateMachine
extends Node

@export var initial_state_val = 0 ## (State.States)

var _states = []
var _states_map = {}
var _active = false

@export var _animation_player: DirectionAnimationPlayer
@export var _host: Node2D


func _ready() -> void:
	_animation_player.animation_finished.connect(_on_animation_finished)
	_init_states()

func _process(delta: float) -> void:
	_states.front().process(delta)

func _on_animation_finished(animation_name: String):
	_states.front().on_animation_finished(animation_name)


func _init_states():
	_states_map = {}

	var children = get_children()
	for child in children:
		var state = child as State
		if not state:
			continue

		_states_map[state.get_state()] = state

	var initial_state = _states_map[initial_state_val]
	_states.push_front(initial_state)
	_states.front().will_enter()

func set_active(value: bool):
	_active = value
	set_physics_process(value)
	set_process_input(value)

func get_host() -> Node2D:
	return _host
	
func get_state_machine() -> StateMachine:
	return self
	
func get_animation_player():
	return _animation_player
	

func change_state(state, params = {}, push = false):
	_animation_player.pause()

	if not _active:
		return
	_states.front().will_exit()

	if not push:
		_states.pop_front()

	if state != -1:
		_states.push_front(_states_map[state])

	if _states.size() > 0:
		_states.front().will_enter(params)
	
func handle_action(_action, _params = {}):
	if not _active:
		return
