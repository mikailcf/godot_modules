class_name BehaviorTreeSequence
extends BehaviorTreeComposite

export (bool) var _skip_success = true

onready var _successful_index = 0

func _reset():
	_successful_index = 0

func will_exit(_metadata):
	_reset()

func _tick(_agent, _blackboard):
	for child in children:
		if child.get_index() < _successful_index and _skip_success:
			continue

		var status = _tick_child(child, _agent, _blackboard)

		if status != SUCCESS:
			if status == FAILURE:
				_reset()
			return status
		
		_successful_index += 1

	if _successful_index == children.size():
		_reset()

	return SUCCESS
