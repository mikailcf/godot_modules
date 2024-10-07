extends Node

signal did_launch_game(timestamp: float)

func _ready():
	did_launch_game.emit(Time.get_unix_time_from_system())
	$Game/Menu.show_menu(false, true, 0, 1.0)
	get_tree().paused = true

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_action_released("ui_cancel"):
		$Game/Menu.pause_game()

func quit():
	print_debug("quit")
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()


func _on_menu_request_quit_game() -> void:
	quit()
