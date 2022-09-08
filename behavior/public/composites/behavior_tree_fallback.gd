class_name BehaviorTreeFallback
extends BehaviorTreeComposite

export (bool) var _skip_failure = true

onready var _last_index = 0

func _reset():
	_last_index = 0

func will_exit(_metadata):
	_reset()

func _tick(_agent, _blackboard):
	for child in children:
		if child.get_index() < _last_index and _skip_failure:
			continue

		var status = _tick_child(child, _agent, _blackboard)

		if status != FAILURE:
			if status == SUCCESS:
				_reset()
			return status
		
		_last_index += 1

	if _last_index == children.size():
		_reset()

	return FAILURE
