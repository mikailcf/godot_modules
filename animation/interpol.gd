## 
## Custom interpoation class
##
class_name Interpol
extends Node

class InterpolationTrack:
	var _active_interpolation_index: int = -1
	var _interpolations: Array[NodeInterpolation] = []
	var _time_skip: float = 0.0
	var _fininshed = false
	
	func _get_active_interpolation() -> NodeInterpolation:
		return _interpolations[_active_interpolation_index]
		
	func append(interpolation: NodeInterpolation):
		if _active_interpolation_index == -1:
			_active_interpolation_index = 0
		
		_interpolations.append(interpolation)
	
	func advance(elapsed_time: float) -> bool:
		if _fininshed or _active_interpolation_index == -1:
			return false
			
		var able_to_advance = _get_active_interpolation().advance(elapsed_time - _time_skip)
		
		if not able_to_advance:
			_active_interpolation_index += 1
			_time_skip = elapsed_time
			
			if _active_interpolation_index == _interpolations.size():
				_fininshed = true
				return false
		
		return true
	
	func _rewind():
		if _active_interpolation_index == -1:
			return
		
		_active_interpolation_index = 0
		_time_skip = 0.0

class NodeInterpolation:
	var _node: Node
	var _path: NodePath
	var _from: Variant
	var _to: Variant
	var _curve: Tween.TransitionType
	var _ease: Tween.EaseType
	var _duration: float
	var _callback: Callable
	var _new_target_callback: Callable
	var _finished: bool = false
	var _to_is_relative: bool = false
	
	func _init(node: Node, path: NodePath, to: Variant,
		duration: float, curve: Tween.TransitionType = Tween.TRANS_LINEAR,
		ease: Tween.EaseType = Tween.EASE_IN_OUT,
		callback: Callable = Callable()):
		_path = path
		_to = to
		_ease = ease
		_curve = curve
		_node = node
		_duration = duration
		_callback = callback
	
	func with_relative_target() -> NodeInterpolation:
		_to_is_relative = true
		return self
	
	func with_updateble_target(new_target: Callable) -> NodeInterpolation:
		_new_target_callback = new_target
		return self
	
	func advance(elapsed_time: float) -> bool:
		if _finished:
			return false
		
		if elapsed_time >= _duration:
			elapsed_time = _duration
			
		if not _from:
			_from = _node.get_indexed(_path)
			
		if _new_target_callback:
			_to = _new_target_callback.call()
		
		var target = _to if _to_is_relative else _to - _from
		var new_value: Variant = Tween.interpolate_value(_from, target, elapsed_time,
			_duration, _curve, _ease)
		_node.set_indexed(_path, new_value)
		
		if elapsed_time == _duration:
			_finished = true
			
			if _callback:
				_callback.call()
			return false
		
		return true
	
	func _update_target(to: Variant):
		_to = to
	
	func _rewind():
		_finished = false

var _elapsed_time: float = 0.0
var _playing = false
var _finished = false
var _tracks: Array[InterpolationTrack] = []

func interpolate_property(node: Node, path: NodePath, to: Variant, duration: float,
	curve: Tween.TransitionType = Tween.TRANS_LINEAR, ease: Tween.EaseType = Tween.EASE_IN_OUT,
	track: int = 0, callback: Callable = func(): pass) -> NodeInterpolation:
	
	var node_interpol = NodeInterpolation.new(node, path, to, duration, curve,
		ease, callback)
	
	if _tracks.size() < track + 1:
		_tracks.append(InterpolationTrack.new())
	
	_tracks[track].append(node_interpol)
	
	return node_interpol

func advance(delta: float):
	if not _playing:
		return
		
	if _finished:
		_playing = false
		return
		
	_elapsed_time += delta
	
	var finished = true
	
	for track in _tracks:
		var able_to_advance = track.advance(_elapsed_time)
		
		if able_to_advance:
			finished = false
	
	_finished = finished

func play():
	if not _playing:
		_playing = true

func is_playing() -> bool:
	return _playing

func rewind():
	_elapsed_time = 0.0
	_playing = false
	_finished = false

	for track in _tracks:
		track._rewind()

func clear():
	_tracks = []
	rewind()
