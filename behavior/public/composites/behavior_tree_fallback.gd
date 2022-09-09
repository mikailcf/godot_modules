class_name BehaviorTreeFallback, "../../icons/fallback.svg"
extends BehaviorTreeComposite

export (bool) var _skip_previous_failure = false

onready var _failure_index = 0

func _reset():
	_failure_index = 0

func _tick(_agent, _blackboard):
	for child in children:
		if child.get_index() < _failure_index \
			and _skip_previous_failure:
			continue

		var status = child.tick(_agent, _blackboard)

		if status != FAILURE:
			if status == SUCCESS:
				_reset()
			return status
		
		_failure_index += 1

	if _failure_index == children.size():
		_reset()

	return FAILURE
