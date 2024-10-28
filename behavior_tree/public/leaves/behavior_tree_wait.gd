@icon("../../icons/wait.svg")
class_name BehaviorTreeWait
extends BehaviorTreeAction

@export var _wait_time: float = 1.0
@export var _one_shot: bool = false
@export var _reset_on_interrupt: bool = true

var _timer: Timer
var _triggered = false

func _ready() -> void:
	super._ready()
	_create_timer()

func _create_timer():
	_timer = Timer.new()
	_timer.one_shot = true
	add_child(_timer)

func _will_exit(blackboard):
	if _reset_on_interrupt:
		_triggered = false

func _do_action(_host, _blackboard, _delta) -> int:
	if _triggered and _timer.is_stopped():
		if not _one_shot:
			_triggered = false
		return BehaviorResult.SUCCESS

	if not _triggered:
		_triggered = true
		_timer.start(_wait_time)

	return BehaviorResult.RUNNING
