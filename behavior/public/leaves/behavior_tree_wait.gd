class_name BehaviorTreeWait
extends BehaviorTreeLeaf

export (float) var _wait_time: float = 1.0
export (bool) var _one_shot: bool = false

var _timer: Timer
var _triggered = false

func _ready() -> void:
	._ready()
	_create_timer()

func _create_timer():
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)

func _tick(_agent: Node, _blackboard: BlackBoard) -> int:
	if _triggered and _timer.is_stopped():
		if not _one_shot:
			_triggered = false
		return SUCCESS

	if not _triggered:
		_triggered = true
		_timer.start(_wait_time)

	return RUNNING


