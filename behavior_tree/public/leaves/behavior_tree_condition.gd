@icon("../../icons/condition.svg")
class_name BehaviorTreeCondition
extends BehaviorTreeNode

@onready var _children = get_children() as Array

func _ready() -> void:
	assert(get_child_count() <= 2) #,"Condition node should have at most 2 children")

func _tick(agent, blackboard: Blackboard) -> int:
	var status = _check_condition(agent, blackboard)
	
	var temp = _children.duplicate()
	var success_child = temp.pop_front() as BehaviorTreeNode
	var failure_child = temp.pop_front() as BehaviorTreeNode
	
	if status == SUCCESS and success_child != null:
		return success_child.tick(agent, blackboard)
	elif status == FAILURE and failure_child != null:
		return failure_child.tick(agent, blackboard)
	
	return status

func _check_condition(_agent, _blackboard: Blackboard) -> int:
	return SUCCESS
