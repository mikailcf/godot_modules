extends BehaviorTreeCondition

# blackboard should have the type YourBlackboard
func _check_condition(host, blackboard: Blackboard) -> int:
	return BehaviorResult.SUCCESS
