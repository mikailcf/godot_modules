class_name BehaviorTreeNode
extends Node

enum BehaviorResult {
	FAILURE,
	SUCCESS,
	RUNNING,
}

@onready var _og_name = name
@onready var _running_name = "X  " + name

func _will_tick():
	name = _running_name
	
func _did_tick(result: BehaviorResult):
	if result == BehaviorResult.SUCCESS:
		name = _og_name
	#pass

func _tick(_host, _blackboard) -> int:
	return BehaviorResult.SUCCESS
	
func _tick_child(child_node: BehaviorTreeNode, host, blackboard) -> BehaviorResult:
	child_node._will_tick()
	var result = child_node._tick(host, blackboard)
	child_node._did_tick(result)
	
	return result
