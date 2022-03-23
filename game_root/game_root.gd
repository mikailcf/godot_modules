class_name GameRoot extends Node

signal game_started(timestamp)

func _ready():
	GameSingleton.game_root = self
	emit_signal("game_started", OS.get_system_time_secs())
