@icon("../../icons/action.svg")
class_name BehaviorTreeAction
extends BehaviorTreeLeaf

func _update_running(blackboard: Blackboard):
	var parent = get_parent()
	var previous_actions = blackboard.running_actions
	var running_actions: Array[BehaviorTreeAction] = []
	
	if previous_actions.has(self):
		return
	
	if not previous_actions.is_empty():
		var previous_parent = previous_actions.front().get_parent()
		
		if previous_parent == parent:
			if parent is BehaviorTreeParallel:
				running_actions = previous_actions
				previous_actions = []

	running_actions.push_back(self)
	blackboard.running_actions = running_actions
	
	for node in previous_actions:
		if node is BehaviorTreeAction:
			node._will_exit(blackboard)

func _update_done(blackboard: Blackboard):
	blackboard.running_actions.erase(self)

func _did_tick(result: BehaviorResult, blackboard: Blackboard):
	super._did_tick(result, blackboard)

	if result == BehaviorResult.RUNNING:
		_update_running(blackboard)
	else:
		_update_done(blackboard)

func _tick(host, blackboard) -> int:
	return _do_action(host, blackboard, blackboard.delta)

func _do_action(_host, _blackboard, _delta: float) -> int:
	return BehaviorResult.SUCCESS
