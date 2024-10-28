@icon("../../../icons/succeeder.svg")
class_name BehaviorTreeSucceeder
extends BehaviorTreeDecorator

func _tick(host, blackboard) -> int:
	var status = child.tick(host, blackboard)

	if status == BehaviorResult.RUNNING:
		return BehaviorResult.RUNNING

	return BehaviorResult.SUCCESS
