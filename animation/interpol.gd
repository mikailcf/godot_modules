## Custom property interpoation class with support for moving targets
##
## It also supports: sequencing and parallelism, curves, easings, relative target. It is supposed to
## be used by keeping an instance of it and advancing the interpolation manually inside a method
## like [method Node._process] or any other that provides a time delta.
class_name Interpol

## Interpol inner class used for sequencing and parallelism, it's not part of the public API.
class InterpolationTrack:
	var _active_interpolation_index: int = -1
	var _interpolations: Array[NodeInterpolation] = []
	var _time_skip: float = 0.0
	var _fininshed = false
	
	func _get_active_interpolation() -> NodeInterpolation:
		return _interpolations[_active_interpolation_index]
		
	func _append(interpolation: NodeInterpolation):
		if _active_interpolation_index == -1:
			_active_interpolation_index = 0
		
		_interpolations.append(interpolation)
	
	func _advance(elapsed_time: float) -> bool:
		if _fininshed or _active_interpolation_index == -1:
			return false
			
		var able_to_advance = _get_active_interpolation()._advance(elapsed_time - _time_skip)
		
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

## Interpol inner class for storing each property interpolation.
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
		ease: Tween.EaseType = Tween.EASE_IN_OUT):
		_path = path
		_to = to
		_ease = ease
		_curve = curve
		_node = node
		_duration = duration
	
	## Builder style function for setting the target to be relative to the starting value, and not
	## absolute.
	func with_relative_target() -> NodeInterpolation:
		_to_is_relative = true
		return self
	
	## Builder style function for setting callback function that returns the new position for the
	## target. It's called during the [method Interpol.advance] function call in the [Interpol] instance.
	func with_updateble_target(new_target: Callable) -> NodeInterpolation:
		_new_target_callback = new_target
		return self
	
	## Sets the callback function to be called at the end of this property interpolation.
	func on_finish(finish_callback: Callable):
		_callback = finish_callback
	
	func _advance(elapsed_time: float) -> bool:
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

## Creates a new property interpolation for a given node and property path. The starting value will
## be the current property value when [method Interpol.advance] is called for the first time in a
## given interpolation (that means that in cases where there are interpolations set up to be played
## in sequence, each interpolation will set its starting point only when the track gets to it).[br][br]
##
## Use the [code]track[/code] parameter to achieve sequencing and parallelism: multiple calls to this
## function with the same track value will be queued (in the same track); multiple calls to this
## function with different track values will be played in parallel (in different tracks).
func interpolate_property(node: Node, path: NodePath, to: Variant, duration: float, track: int = 0,
	curve: Tween.TransitionType = Tween.TRANS_LINEAR, ease: Tween.EaseType = Tween.EASE_IN_OUT) ->\
	NodeInterpolation:
	
	var node_interpol = NodeInterpolation.new(node, path, to, duration, curve, ease)
	
	while _tracks.size() < track + 1:
		_tracks.append(InterpolationTrack.new())
	
	_tracks[track]._append(node_interpol)
	
	return node_interpol

## Advances the interpolation tracks by [code]delta[/code] seconds. Marks the interpolation as
## finished, if such is the case.[br][br]
## Must be used after calling [method Interpol.play].
func advance(delta: float):
	if not _playing:
		return
		
	if _finished:
		_playing = false
		return
		
	_elapsed_time += delta
	
	var finished = true
	
	for track in _tracks:
		var able_to_advance = track._advance(_elapsed_time)
		
		if able_to_advance:
			finished = false
	
	_finished = finished

## Enables the interpolation to be advanced.
func play():
	if not _playing:
		_playing = true

## Returns the playing state.
func is_playing() -> bool:
	return _playing

## Returns the finished state.
func is_finished() -> bool:
	return _finished

## Resets the playback values to the initial ones whilst keeping original track and node interpolation
## information.
func rewind():
	_elapsed_time = 0.0
	_playing = false
	_finished = false

	for track in _tracks:
		track._rewind()

## Empties all data stored by the interpolation instance.
func clear():
	_tracks = []
	rewind()
