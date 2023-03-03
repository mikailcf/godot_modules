class_name Interpol
extends Node

var _tween: Tween
var _duration: float
var _elapsed_time: float
var _from: Variant
var _to: Variant
var _curve: Tween.TransitionType
var _ease: Tween.EaseType
var _finished = false
var _current_value: Variant
var _set_up = false
var _callback: Callable

func setup(from: Variant, to: Variant, duration: float,
	curve: Tween.TransitionType = Tween.TRANS_LINEAR, ease: Tween.EaseType = Tween.EASE_IN_OUT,
	callback: Callable = func(): pass):
	_tween = self.create_tween()
	_from = from
	_to = to
	_duration = duration
	_ease = ease
	_curve = curve
	_elapsed_time = 0.0
	_set_up = true
	_callback = callback

func advance(delta: float) -> Variant:
	if _finished:
		return _to
		
	_elapsed_time += delta
	
	if _elapsed_time >= _duration:
		_finished = true
		_elapsed_time = _duration
		_current_value = _to
		_callback.call()
		
		return _to
		
	_current_value = _tween.interpolate_value(
		_from,
		_to - _from,
		_elapsed_time,
		_duration,
		_curve,
		_ease)
		
	return _current_value

func is_set_up() -> bool:
	return _set_up

func update_target(to: Variant):
	_to = to
