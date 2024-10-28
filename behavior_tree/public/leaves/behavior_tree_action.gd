@icon("../../icons/action.svg")
class_name BehaviorTreeAction
extends BehaviorTreeLeaf

func _interrupt(blackboard):
	pass

func _tick(host, blackboard) -> int:
	return _do_action(host, blackboard, blackboard.delta)

func _do_action(_host, _blackboard, _delta: float) -> int:
	return BehaviorResult.SUCCESS
