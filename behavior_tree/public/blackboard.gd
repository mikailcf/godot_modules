@icon("../icons/blackboard.svg")
class_name Blackboard
extends Node

var _blackboard = {}
var delta: float

func set_value(key, value, scope = 'default'):
	if not _blackboard.has(scope):
		_blackboard[scope] = {}

	_blackboard[scope][key] = value

func get_value(key, default_value = null, scope = 'default'):
	if has_value(key, scope):
		return _blackboard[scope].get(key, default_value)
	return default_value

func has_value(key, scope = 'default'):
	return _blackboard.has(scope) \
		and _blackboard[scope].has(key) \
		and _blackboard[scope][key] != null

func erase_value(key, scope = 'default'):
	if _blackboard.has(scope):
		_blackboard[scope][key] = null
