extends Node

func _input(event: InputEvent) -> void:
	if event.is_action_released("ui_cancel"):
		$"..".unpause_game()

func start_focus():
	$"../Control/MarginContainer/HBoxContainer/MainMenuVBoxContainer/NewGameButton"\
		.grab_focus()

func _on_NewGameButton_pressed() -> void:
	$"..".start_game()

func _on_QuitButton_pressed() -> void:
	$"..".request_quit_game.emit()
