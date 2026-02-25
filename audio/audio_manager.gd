class_name AudioManager
extends Node

signal music_started(stream: AudioStream)
signal music_stopped

@export var sfx_bus: String = "SFX"
@export var music_bus: String = "Music"
@export var pool_size: int = 8

var _sfx_pool: Array[AudioStreamPlayer] = []
var _music_player_a: AudioStreamPlayer
var _music_player_b: AudioStreamPlayer
var _active_music_player: AudioStreamPlayer
var _current_tween: Tween


func _ready() -> void:
	_init_sfx_pool()
	_init_music_players()


func _init_sfx_pool() -> void:
	for i in pool_size:
		var player = AudioStreamPlayer.new()
		player.bus = sfx_bus
		add_child(player)
		_sfx_pool.append(player)


func _init_music_players() -> void:
	_music_player_a = AudioStreamPlayer.new()
	_music_player_a.bus = music_bus
	add_child(_music_player_a)

	_music_player_b = AudioStreamPlayer.new()
	_music_player_b.bus = music_bus
	add_child(_music_player_b)

	_active_music_player = _music_player_a


# --- SFX ---

func play_sfx(stream: AudioStream, volume_db: float = 0.0) -> AudioStreamPlayer:
	var player = _get_idle_sfx_player()
	player.stream = stream
	player.volume_db = volume_db
	player.play()
	return player


func stop_sfx(player: AudioStreamPlayer) -> void:
	player.stop()


func _get_idle_sfx_player() -> AudioStreamPlayer:
	for player in _sfx_pool:
		if not player.playing:
			return player

	var player = AudioStreamPlayer.new()
	player.bus = sfx_bus
	add_child(player)
	_sfx_pool.append(player)
	return player


# --- Music ---

func play_music(stream: AudioStream, fade_duration: float = 1.0) -> void:
	var next_player = _get_inactive_music_player()
	next_player.stream = stream
	next_player.volume_db = -80.0
	next_player.play()

	var previous_player = _active_music_player
	_active_music_player = next_player

	if _current_tween:
		_current_tween.kill()

	_current_tween = create_tween().set_parallel(true)
	_current_tween.tween_property(previous_player, "volume_db", -80.0, fade_duration)
	_current_tween.tween_property(next_player, "volume_db", 0.0, fade_duration)
	_current_tween.finished.connect(
		func():
			previous_player.stop()
			music_started.emit(stream),
		CONNECT_ONE_SHOT
	)


func stop_music(fade_duration: float = 1.0) -> void:
	if not _active_music_player.playing:
		return

	if _current_tween:
		_current_tween.kill()

	var player_to_stop = _active_music_player
	_current_tween = create_tween()
	_current_tween.tween_property(player_to_stop, "volume_db", -80.0, fade_duration)
	_current_tween.finished.connect(
		func():
			player_to_stop.stop()
			music_stopped.emit(),
		CONNECT_ONE_SHOT
	)


func _get_inactive_music_player() -> AudioStreamPlayer:
	if _active_music_player == _music_player_a:
		return _music_player_b
	return _music_player_a


# --- Bus control ---

func set_bus_volume(bus_name: String, volume_db: float) -> void:
	var idx = AudioServer.get_bus_index(bus_name)
	if idx != -1:
		AudioServer.set_bus_volume_db(idx, volume_db)


func get_bus_volume(bus_name: String) -> float:
	var idx = AudioServer.get_bus_index(bus_name)
	if idx != -1:
		return AudioServer.get_bus_volume_db(idx)
	return 0.0


func set_bus_muted(bus_name: String, muted: bool) -> void:
	var idx = AudioServer.get_bus_index(bus_name)
	if idx != -1:
		AudioServer.set_bus_mute(idx, muted)


func is_bus_muted(bus_name: String) -> bool:
	var idx = AudioServer.get_bus_index(bus_name)
	if idx != -1:
		return AudioServer.is_bus_mute(idx)
	return false
