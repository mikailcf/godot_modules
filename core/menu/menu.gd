extends CanvasLayer

signal request_play_game
signal request_quit_game

enum BGType { None = 0, Blur }

var _pause: bool = false

func _ready() -> void:
	$Control.visible = false

func show_menu(_pause: bool = false, animated: bool = false, bg_type: int = 0, duration: float = -1):
	$InputControllerNode.start_focus()
	$AnimationControllerNode.show_menu(animated, bg_type, duration)

func hide_menu(animated: bool = false, duration: float = -1):
	$AnimationControllerNode.hide_menu(animated, duration)

func pause_game():
	get_tree().paused = true
	_pause = true
	$Control/MarginContainer/HBoxContainer/MainMenuVBoxContainer/NewGameButton\
		.configure(_pause)

	show_menu(true, true, BGType.Blur)

func unpause_game():
	_pause = false
	hide_menu(true)
	$Control/MarginContainer/HBoxContainer/MainMenuVBoxContainer/NewGameButton\
		.configure(_pause)

func start_game():
	if _pause:
		unpause_game()
	else:
		hide_menu(true, 1)

func quit_game():
	request_quit_game.emit()

func _on_AnimationControllerNode_finished_hiding_menu() -> void:
	get_tree().paused = false
	request_play_game.emit()

func _on_GameRoot_game_started(_timestamp) -> void:
	$InputControllerNode.start_focus()
