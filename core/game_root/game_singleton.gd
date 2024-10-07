# needs to be autoloaded
extends Node

var game_root: GameRoot

func quit():
	print_debug("quit")
	get_tree().get_root().propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
