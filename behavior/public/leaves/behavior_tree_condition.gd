class_name BehaviorTreeCondition, "../../icons/condition.svg"
extends BehaviorTreeLeaf

func _tick(agent: Node, blackboard: BlackBoard) -> int:
	return _check_condition(agent, blackboard)

func _check_condition(_agent: Node, _blackboard: BlackBoard) -> int:
	return SUCCESS