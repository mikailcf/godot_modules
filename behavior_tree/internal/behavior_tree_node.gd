class_name BehaviorTreeNode
extends Node

enum BehaviorResult {
	FAILURE,
	SUCCESS,
	RUNNING,
}

@onready var _og_name = name
@onready var _running_name = "X  " + name

func will_exit(_metadata: Dictionary):
	pass

func _tick(_host, _blackboard) -> int:
	return BehaviorResult.SUCCESS
