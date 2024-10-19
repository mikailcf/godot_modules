class_name BehaviorTreeNode
extends Node

enum {
	FAILURE,
	SUCCESS,
	RUNNING,
}

@onready var _og_name = name
@onready var _running_name = "X  " + name

func will_exit(_metadata: Dictionary):
	pass

func tick(agent, blackboard: Blackboard) -> int:
	var status = _tick(agent, blackboard)
	return status

func _tick(_agent, _blackboard: Blackboard) -> int:
	return SUCCESS
