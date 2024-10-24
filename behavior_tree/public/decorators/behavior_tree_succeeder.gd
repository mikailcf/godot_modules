@icon("../../icons/succeeder.svg")
class_name BehaviorTreeSucceeder
extends BehaviorTreeDecorator

func _tick(_host, _blackboard) -> int:
	var status = _child._tick(_host, _blackboard)

	if status == BehaviorResult.RUNNING:
		return BehaviorResult.RUNNING

	return BehaviorResult.SUCCESS
