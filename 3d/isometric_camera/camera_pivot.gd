@tool
extends Marker3D

@export_node_path("Node3D") var _target_path
@onready var _target_node = get_node(_target_path)

@export var _speed: float = 0.1
@export var _distance: float = 2.0

var _last_distance = 0.0

func _ready():
	_update_camera_distance()

func _physics_process(delta: float) -> void:
	var from := transform.origin
	var to = _target_node.transform.origin

	transform.origin = lerp(from, to, _speed)
	
	if _last_distance != _distance:
		_update_camera_distance()
		_last_distance = _distance

func _update_camera_distance():
	$Camera3D.transform.origin = Vector3(0.0, 0.0, _distance)
