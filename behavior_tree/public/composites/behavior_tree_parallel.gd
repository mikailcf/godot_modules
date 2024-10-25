@icon("../../icons/parallel.svg")
class_name BehaviorTreeParallel
extends BehaviorTreeComposite

func _tick(_host, _blackboard):
	for child in children:
		_tick_child(child, _host, _blackboard)

	return BehaviorResult.SUCCESS
