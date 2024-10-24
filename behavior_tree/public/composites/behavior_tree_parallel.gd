@icon("../../icons/parallel.svg")
class_name BehaviorTreeParallel
extends BehaviorTreeComposite

func _tick(_host, _blackboard):
	for child in children:
		child._tick(_host, _blackboard)

	return BehaviorResult.SUCCESS
