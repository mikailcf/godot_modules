class_name BehaviorTreeCondition, "../../icons/condition.svg"
extends BehaviorTreeLeaf

func _tick(agent, blackboard: BlackBoard) -> int:
	return _check_condition(agent, blackboard)

func _check_condition(_agent, _blackboard: BlackBoard) -> int:
	return SUCCESS