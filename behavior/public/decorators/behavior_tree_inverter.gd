class_name BehaviorTreeInverter
extends BehaviorTreeDecorator

func _tick(_agent, _blackboard) -> int:
	var status = _tick_child(_child, _agent, _blackboard)

	if status == SUCCESS:
		return FAILURE
	elif status == FAILURE:
		return SUCCESS
	
	return RUNNING