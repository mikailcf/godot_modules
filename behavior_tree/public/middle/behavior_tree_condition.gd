@icon("../../icons/condition.svg")
class_name BehaviorTreeCondition
extends BehaviorTreeNode

@onready var _children = get_children() as Array

func _ready() -> void:
	assert(get_child_count() <= 2 and get_child_count() > 0) #,"Condition node should have at most 2 children")

func _tick(host, blackboard) -> int:
	var status = _check_condition(host, blackboard)
	
	var temp = _children.duplicate()
	var success_child = temp.pop_front() as BehaviorTreeNode
	var failure_child = temp.pop_front() as BehaviorTreeNode
	
	if status == BehaviorResult.SUCCESS and success_child != null:
		return success_child.tick(host, blackboard)
	elif status == BehaviorResult.FAILURE and failure_child != null:
		return failure_child.tick(host, blackboard)
	
	return status

func _check_condition(_host, _blackboard) -> int:
	return BehaviorResult.SUCCESS
