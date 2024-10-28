@icon("../../../icons/inverter.svg")
class_name BehaviorTreeInverter
extends BehaviorTreeDecorator

func _tick(host, blackboard) -> int:
	var status = child.tick(host, blackboard)

	if status == BehaviorResult.SUCCESS:
		return BehaviorResult.FAILURE
	elif status == BehaviorResult.FAILURE:
		return BehaviorResult.SUCCESS
	
	return BehaviorResult.RUNNING
