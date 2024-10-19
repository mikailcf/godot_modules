@icon("../../icons/action.svg")
class_name BehaviorTreeAction
extends BehaviorTreeLeaf

func _tick(agent, blackboard: Blackboard) -> int:
	return _do_action(agent, blackboard)

func _do_action(_agent, _blackboard: Blackboard) -> int:
	return SUCCESS
