class_name Storage
extends Node

const file_prefix = "user://save"

static func save_data(slot: int, data: Dictionary) -> void:
	var json = JSON.print(data, "  ")
	var file = File.new()
	var filename = file_prefix + str(slot)
	
	file.open(filename, File.WRITE)
	file.store_string(json)
	file.close()

static func load_data(slot: int) -> Dictionary:
	var file = File.new()
	var filename = file_prefix + str(slot)
	var error = file.open(filename, File.READ)

	if not error == OK:
		print("Could not load file at " + filename)
		return {}

	var input = file.get_as_text()
	file.close()
	var data: Dictionary = JSON.parse(input).result
	return data

static func save_options():
	