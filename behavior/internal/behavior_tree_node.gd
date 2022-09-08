class_name BehaviorTreeNode
extends Node

enum {
	FAILURE,
	SUCCESS,
	RUNNING,
}

var _running_stack: Array
var _depth: int

func will_exit(_metadata: Dictionary):
	_running_stack = []
	pass

func _metadata() -> Dictionary:
	return {}

func _update_running_stack():
	if _running_stack.size() < _depth + 1:
		_running_stack.push_back(self)
		return
	
	if not _running_stack[_depth] == self:
		var stack_to_keep = _running_stack.slice(0, _depth - 1)
		var length = _running_stack.size()
		var stack_to_cut = _running_stack.slice(_depth, length - 1)

		for node in stack_to_cut:
			node.will_exit(_metadata())
		
		_running_stack = stack_to_keep

func tick(
	agent: Node,
	blackboard: BlackBoard,
	running_stack: Array,
	depth: int
) -> int:
	_running_stack = running_stack
	_depth = depth
	_update_running_stack()

	return _tick(agent, blackboard)

func _tick(_agent: Node, _blackboard: BlackBoard) -> int:
	return SUCCESS

func _tick_child(
	node: BehaviorTreeNode,
	agent: Node,
	blackboard: BlackBoard
) -> int:
	return node.tick(
		agent,
		blackboard,
		_running_stack,
		_depth + 1
	)