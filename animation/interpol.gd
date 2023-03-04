## Custom interpoation class
##
## Instances of this class are intended to be reused or freed manually to avoid memory leaks
##
class_name Interpol
extends Node

var _tween: Tween
var _duration: float
var _elapsed_time: float
var _finished = false
var _current_value: Variant
var _set_up = false
var _callback: Callable
var _node_interpols = {}

class NodeInterpolation:
	var _node: Node
	var _path: NodePath
	var _from: Variant
	var _to: Variant
	var _curve: Tween.TransitionType
	var _ease: Tween.EaseType
	var _tween: Tween
	
	func _init(node: Node, path: NodePath, from: Variant, to: Variant,
		curve: Tween.TransitionType = Tween.TRANS_LINEAR, ease: Tween.EaseType = Tween.EASE_IN_OUT):
		_path = path
		_tween = node.create_tween()
		_from = from
		_to = to
		_ease = ease
		_curve = curve
		_node = node
	
	func free():
		_tween.kill()
		_tween.free()
	
	func advance(elapsed_time: float, duration: float):
		var new_value: Variant = _tween.interpolate_value(_from, _to - _from, elapsed_time,
			duration, _curve, _ease)
		_node.set_indexed(_path, new_value)
	
	func update_target(to: Variant):
		_to = to

func free():
	for interpol in _node_interpols.values():
		interpol.free()
	super()

func setup(duration: float, callback: Callable = func(): pass):
	_duration = duration
	_elapsed_time = 0.0
	_set_up = true
	_callback = callback

func interpolate_property(node: Node, path: NodePath, from: Variant, to: Variant,
	curve: Tween.TransitionType = Tween.TRANS_LINEAR, ease: Tween.EaseType = Tween.EASE_IN_OUT):
	_node_interpols[str(node.get_instance_id()) + str(path)] = \
		NodeInterpolation.new(node, path, from, to, curve, ease)

func advance(delta: float):
	if _finished:
		return
		
	_elapsed_time += delta
	
	if _elapsed_time >= _duration:
		_finished = true
		_elapsed_time = _duration
		_callback.call()
		return
	
	for interpol in _node_interpols.values():
		interpol.advance(_elapsed_time, _duration)

func is_set_up() -> bool:
	return _set_up

func update_target(node: Node, path: NodePath, to: Variant):
	if not _node_interpols.has(str(node.get_instance_id()) + str(path)):
		return
	
	var interpol = _node_interpols.get(str(node.get_instance_id()) + str(path)) as NodeInterpolation
	interpol.update_target(to)

func rewind():
	_set_up = false
	_elapsed_time = 0.0
	_finished = 0.0
