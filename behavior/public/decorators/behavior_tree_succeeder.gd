class_name BehaviorTreeSucceeder, "../../icons/succeeder.svg"
extends BehaviorTreeDecorator

func _tick(_agent, _blackboard) -> int:
	var status = _child.tick(_agent, _blackboard)

	if status == RUNNING:
		return RUNNING

	return SUCCESS