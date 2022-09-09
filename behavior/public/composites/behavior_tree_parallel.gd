class_name BehaviorTreeParallel, "../../icons/parallel.svg"
extends BehaviorTreeComposite

func _tick(_agent, _blackboard):
	for child in children:
		child.tick(_agent, _blackboard)

	return SUCCESS
