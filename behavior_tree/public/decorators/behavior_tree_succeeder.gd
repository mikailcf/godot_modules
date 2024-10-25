@icon("../../icons/succeeder.svg")
class_name BehaviorTreeSucceeder
extends BehaviorTreeDecorator

func _tick(_host, _blackboard) -> int:
	var status = _tick_child(child, _host, _blackboard)

	if status == BehaviorResult.RUNNING:
		return BehaviorResult.RUNNING

	return BehaviorResult.SUCCESS
