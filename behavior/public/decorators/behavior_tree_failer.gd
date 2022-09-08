class_name BehaviorTreeFailer
extends BehaviorTreeDecorator

func _tick(_agent, _blackboard) -> int:
	var status = _tick_child(_child, _agent, _blackboard)

	if status == RUNNING:
		return RUNNING
		
	return FAILURE