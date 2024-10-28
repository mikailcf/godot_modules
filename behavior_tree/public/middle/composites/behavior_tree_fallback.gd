@icon("../../../icons/fallback.svg")
class_name BehaviorTreeFallback
extends BehaviorTreeComposite

@export var _skip_previous_failure: bool = false

@onready var _failure_index = 0

func _reset():
	_failure_index = 0

func _tick(host, blackboard):
	for child in children:
		if child.get_index() < _failure_index \
			and _skip_previous_failure:
			continue

		var status = child.tick(host, blackboard)

		if status != BehaviorResult.FAILURE:
			if status == BehaviorResult.SUCCESS:
				_reset()
			return status
		
		_failure_index += 1

	if _failure_index == children.size():
		_reset()

	return BehaviorResult.FAILURE
