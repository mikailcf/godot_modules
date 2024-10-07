extends Node

signal finished_showing_menu
signal finished_hiding_menu

var _bgfx: int = 0
var _previous_duration: float

func show_menu(animated: bool, bgfx: int = 0, duration: float = -1.0):
	_bgfx = bgfx
	
	var playback_speed = 1.0

	if not duration == -1:
		playback_speed = 1.0 / duration

	$MainAnimationPlayer.play("show_menu", -1, playback_speed)

	match bgfx:
		0:
			$BGFXAnimationPlayer.play("none", -1, playback_speed)
		1:
			$BGFXAnimationPlayer.play("show_blur", -1, playback_speed)

	if not animated:
		var animation_time = $MainAnimationPlayer.get_animation("show_menu").length
		$MainAnimationPlayer.seek(animation_time)
		$BGFXAnimationPlayer.seek(animation_time)

func hide_menu(animated, duration: float = -1.0):
	$MainAnimationPlayer.play("hide_menu")
	
	var playback_speed = 1.0

	if not duration == -1:
		playback_speed = 1.0 / duration

	match _bgfx:
		0:
			$BGFXAnimationPlayer.play("none", -1, playback_speed)
		1:
			$BGFXAnimationPlayer.play("hide_blur", -1, playback_speed)

	if not animated:
		var animation_time = $MainAnimationPlayer.get_animation("hide_menu").length
		$MainAnimationPlayer.seek(animation_time)
		$BGFXAnimationPlayer.seek(animation_time)


func _on_MainAnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "hide_menu":
		finished_hiding_menu.emit()
#
#	if anim_name == "show_menu":
#		emit_signal("finished_showing_menu")
