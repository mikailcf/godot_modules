class_name SceneLoaderNode
extends Node

enum Storage { PUSH = 0, POP, REPLACE }

@export var _new_scene_path # (String, FILE, "*.tscn")

func _scene_loader() -> SceneLoader:
	return get_tree().get_nodes_in_group("scene_loader").front() as SceneLoader

func change_scene_to_file(storage: int, animated: bool):
	match storage:
		Storage.PUSH:
			_scene_loader().push_scene(_new_scene_path, animated)
		Storage.POP:
			_scene_loader().pop_scene(animated)
