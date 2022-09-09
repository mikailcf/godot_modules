class_name BehaviorTree, "../icons/tree.svg"
extends Node

enum ProcessMode {
	PHYSICS_PROCESS,
	IDLE,
	MANUAL
}

export (ProcessMode) var _process_mode = \
	ProcessMode.PHYSICS_PROCESS setget set_process_mode
export (bool) var _enabled = true
export (NodePath) var _agent_path
export (NodePath) var _blackboard_path

onready var _root := get_child(0) as BehaviorTreeNode
onready var _agent = get_node(_agent_path) as Node
onready var _blackboard = \
	get_node(_blackboard_path) as BlackBoard

func _ready():
	assert(get_child_count() == 1, "Root node should have one child")
	set_process_mode(self._process_mode)

func _process(delta: float):
	tick(delta)
	
func _physics_process(delta: float):
	tick(delta)

func tick(delta):
	_blackboard.delta = delta
	_root.tick(_agent, _blackboard)

func enable():
	_enabled = true
	set_process_mode(_process_mode)

func disable():
	_enabled = false
	set_process(_enabled)
	set_physics_process(_enabled)

func set_process_mode(value: int):
	_process_mode = value
	set_process(value == ProcessMode.IDLE)
	set_physics_process(value == ProcessMode.PHYSICS_PROCESS)
