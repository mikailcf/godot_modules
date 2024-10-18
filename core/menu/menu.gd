extends CanvasLayer

signal request_play_game
signal request_quit_game

@export var animation_duration: float = 0.01

enum BGType { None = 0, Blur }

var _is_paused: bool = false

func _ready() -> void:
	#pass
	$Control.visible = false

func show_menu(should_pause: bool = false, animated: bool = false, bg_type: int = 0, duration: float = animation_duration):
	get_tree().paused = should_pause
	$InputControllerNode.start_focus()
	$AnimationControllerNode.show_menu(animated, bg_type, duration)

func hide_menu(animated: bool = false, duration: float = animation_duration):
	$AnimationControllerNode.hide_menu(animated, duration)

func pause_game():
	_is_paused = true
	$Control/MarginContainer/HBoxContainer/MainMenuVBoxContainer/NewGameButton\
		.configure(_is_paused)

	show_menu(true, true, BGType.Blur)

func unpause_game():
	_is_paused = false
	hide_menu(true)

func start_game():
	if _is_paused:
		unpause_game()
	else:
		hide_menu(true)

func quit_game():
	request_quit_game.emit()

func _on_AnimationControllerNode_finished_hiding_menu() -> void:
	get_tree().paused = false
	request_play_game.emit()

func _on_GameRoot_game_started(_timestamp) -> void:
	$InputControllerNode.start_focus()
