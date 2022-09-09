class_name BehaviorTreeInverter, "../../icons/inverter.svg"
extends BehaviorTreeDecorator

func _tick(_agent, _blackboard) -> int:
	var status = _child.tick(_agent, _blackboard)

	if status == SUCCESS:
		return FAILURE
	elif status == FAILURE:
		return SUCCESS
	
	return RUNNING