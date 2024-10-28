@icon("../../icons/failer.svg")
class_name BehaviorTreeFailer
extends BehaviorTreeDecorator

func _tick(host, blackboard) -> int:
	var status = child.tick(host, blackboard)

	if status == BehaviorResult.RUNNING:
		return BehaviorResult.RUNNING
		
	return BehaviorResult.FAILURE
