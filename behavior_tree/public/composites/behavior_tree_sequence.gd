@icon("../../icons/sequence.svg")
class_name BehaviorTreeSequence
extends BehaviorTreeComposite

@export var _skip_previous_success: bool = true

@onready var _successful_index = 0

func _reset():
	_successful_index = 0

func _tick(host, blackboard):
	for child in children:
		if child.get_index() < _successful_index \
			and _skip_previous_success:
			continue

		var status = child.tick(host, blackboard)

		if status != BehaviorResult.SUCCESS:
			if status == BehaviorResult.FAILURE:
				_reset()
			return status
		
		_successful_index += 1

	if _successful_index == children.size():
		_reset()

	return BehaviorResult.SUCCESS
