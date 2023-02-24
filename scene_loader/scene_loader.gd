class_name SceneLoader
extends Node

@export var _node_path_to_replace: NodePath

var _stack = []
var _node_to_remove: Node
var _parent_to_remove_from: Node

func _ready():
	add_to_group("scene_loader")
	unique_name_in_owner = true

func _node_from_scene(scene_path) -> Node:
	return load(scene_path).instantiate()

func _change_to_scene_node(new_scene_node: Node, animated: bool):
	_node_to_remove = get_node(_node_path_to_replace)
	_parent_to_remove_from = _node_to_remove.get_parent()

	await RenderingServer.frame_post_draw
	var img = get_viewport().get_texture().get_image()
	img.flip_y()
	
	var tex = ImageTexture.create_from_image(img)

	$CanvasLayer/TextureRect.texture = tex

	new_scene_node.name = "Level"
	_parent_to_remove_from.remove_child(_node_to_remove)
	_parent_to_remove_from.add_child(new_scene_node)
	_start_animation(not animated)

func change_to_scene(new_scene_path: String, animated: bool):
	_change_to_scene_node(_node_from_scene(new_scene_path), animated)

func push_scene(new_scene_path: String, animated: bool):
	_stack.append(get_node(_node_path_to_replace))
	change_to_scene(new_scene_path, animated)

func pop_scene(animated: bool):
	if _stack.is_empty():
		return

	_change_to_scene_node(_stack.back(), animated)
	_stack.pop_back()

func _start_animation(instant: bool):
	$AnimationPlayer.play("fade_animation")

	if instant:
		var animation_time = $AnimationPlayer.get_animation("fade_animation").length
		$AnimationPlayer.seek(animation_time)

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "fade_animation":
		$CanvasLayer/TextureRect.texture = null
