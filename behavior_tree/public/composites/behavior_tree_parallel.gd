@icon("../../icons/parallel.svg")
class_name BehaviorTreeParallel
extends BehaviorTreeComposite

func _tick(host, blackboard):
	for child in children:
		child.tick(host, blackboard)

	return BehaviorResult.SUCCESS
