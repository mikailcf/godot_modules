# needs to be autoloaded
extends Node

var game_root: GameRoot

func quit():
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)
