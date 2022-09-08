class_name BlackBoard
extends Node

var _blackboard = {}
var delta: float

func set(key, value, scope = 'default'):
	if not _blackboard.has(scope):
		_blackboard[scope] = {}

	_blackboard[scope][key] = value

func get(key, default_value = null, scope = 'default'):
	if has(key, scope):
		return _blackboard[scope].get(key, default_value)
	return default_value

func has(key, scope = 'default'):
	return _blackboard.has(scope) \
		and _blackboard[scope].has(key) \
		and _blackboard[scope][key] != null

func erase(key, scope = 'default'):
	if _blackboard.has(scope):
		 _blackboard[scope][key] = null