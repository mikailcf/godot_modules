@icon("../../icons/failer.svg")
class_name BehaviorTreeFailer
extends BehaviorTreeDecorator

func _tick(_agent, _blackboard) -> int:
	var status = _child.tick(_agent, _blackboard)

	if status == RUNNING:
		return RUNNING
		
	return FAILURE
