@icon("../../icons/inverter.svg")
class_name BehaviorTreeInverter
extends BehaviorTreeDecorator

func _tick(_host, _blackboard) -> int:
	var status = _child._tick(_host, _blackboard)

	if status == BehaviorResult.SUCCESS:
		return BehaviorResult.FAILURE
	elif status == BehaviorResult.FAILURE:
		return BehaviorResult.SUCCESS
	
	return BehaviorResult.RUNNING
