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
	pass

func _will_exit(blackboard):
	pass

func _did_tick(result: BehaviorResult, blackboard: Blackboard):
	if result == BehaviorResult.RUNNING:
		name = _running_name
	else:
		name = _og_name

func _tick(_host, _blackboard) -> int:
	return BehaviorResult.SUCCESS
	
func tick(host, blackboard) -> int:
	_will_tick()
	var result = _tick(host, blackboard)
	_did_tick(result, blackboard)
	
	return result
