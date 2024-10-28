extends BehaviorTreeAction

signal act

# blackboard should have the type YourBlackboard
func _interrupt(blackboard: Blackboard):
	pass

# blackboard should have the type YourBlackboard
func _do_action(host, blackboard: Blackboard, delta: float) -> int:
	return BehaviorResult.SUCCESS
