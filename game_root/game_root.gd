class_name GameRoot extends Node

signal game_started(timestamp)

func _ready():
	GameSingleton.game_root = self
	emit_signal("game_started", Time.get_unix_time_from_system)
