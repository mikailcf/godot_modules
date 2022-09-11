class_name BehaviorTreeAction, "../../icons/action.svg"
extends BehaviorTreeLeaf

func _tick(agent, blackboard: BlackBoard) -> int:
	return _do_action(agent, blackboard)

func _do_action(_agent, _blackboard: BlackBoard) -> int:
	return SUCCESS
