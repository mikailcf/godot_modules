@icon("../../icons/wait.svg")
class_name BehaviorTreeWait
extends BehaviorTreeLeaf

@export var _wait_time: float = 1.0
@export var _one_shot: bool = false

var _timer: Timer
var _triggered = false

func _ready() -> void:
	super._ready()
	_create_timer()

func _create_timer():
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)

func _tick(_host, _blackboard) -> int:
	if _triggered and _timer.is_stopped():
		if not _one_shot:
			_triggered = false
		return BehaviorResult.SUCCESS

	if not _triggered:
		_triggered = true
		_timer.start(_wait_time)

	return BehaviorResult.RUNNING
