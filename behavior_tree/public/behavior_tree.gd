@icon("res://../icons/tree.svg")
class_name BehaviorTree
extends Node

enum ProcessType {
	PHYSICS_PROCESS,
	IDLE,
	MANUAL
}

@export var _process_type: ProcessType:
	set = set_process_type
@export var _enabled: bool = true

@onready var _root := get_child(0) as BehaviorTreeNode
@export var _host: Node
@export var _blackboard: Blackboard

var _running_actions: Array[BehaviorTreeNode] = []

func _ready():
	assert(get_child_count() == 1) # Tree node should have one child, the root
	set_process_type(ProcessType.PHYSICS_PROCESS)

func _process(delta: float):
	_tick(delta)
	
func _physics_process(delta: float):
	_tick(delta)

func _tick(delta):
	_blackboard.delta = delta
	_root.tick(_host, _blackboard)

func enable():
	_enabled = true
	set_process_type(_process_type)

func disable():
	_enabled = false
	set_process(_enabled)
	set_physics_process(_enabled)

func set_process_type(value: ProcessType):
	_process_type = value
	set_process(value == ProcessType.IDLE)
	set_physics_process(value == ProcessType.PHYSICS_PROCESS)
