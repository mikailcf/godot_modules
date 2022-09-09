class_name BehaviorTreeNode
extends Node

enum {
	FAILURE,
	SUCCESS,
	RUNNING,
}

onready var _og_name = name
onready var _running_name = "X  " + name

func will_exit(_metadata: Dictionary):
	pass

func tick(agent: Node, blackboard: BlackBoard) -> int:
	return _tick(agent, blackboard)

func _tick(_agent: Node, _blackboard: BlackBoard) -> int:
	return SUCCESS
