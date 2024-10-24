@icon("../../icons/failer.svg")
class_name BehaviorTreeFailer
extends BehaviorTreeDecorator

func _tick(_host, _blackboard) -> int:
	var status = _child._tick(_host, _blackboard)

	if status == BehaviorResult.RUNNING:
		return BehaviorResult.RUNNING
		
	return BehaviorResult.FAILURE
