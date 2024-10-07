class_name Storage
extends Node

const file_prefix = "user://save"

static func save_data(slot: int, data: Dictionary) -> void:
	var json = JSON.stringify(data, "  ")
	var filename = file_prefix + str(slot)
	
	var file = FileAccess.open_compressed(filename, FileAccess.WRITE)
	file.store_string(json)
	file.close()

static func load_data(slot: int) -> Dictionary:
	var filename = file_prefix + str(slot)
	var file = FileAccess.open_compressed(filename, FileAccess.READ)

	if file == null:
		print("Could not load file at " + filename)
		return {}

	var input = file.get_as_text()
	file.close()
	var test_json_conv = JSON.new()
	var error = test_json_conv.parse(input)
	
	if error:
		print("Could not parse data from " + filename)
		return {}
	
	var data: Dictionary = test_json_conv.data
	return data

static func save_options():
	var config = ConfigFile.new()

	# Store some values.
	config.set_value("Player1", "player_name", "Steve")
	config.set_value("Player1", "best_score", 10)
	config.set_value("Player2", "player_name", "V3geta")
	config.set_value("Player2", "best_score", 9001)

	# Save it to a file (overwrite if already exists).
	config.save("user://scores.cfg")

static func load_options():
	var score_data = {}
	var config = ConfigFile.new()

	# Load data from a file.
	var err = config.load("user://scores.cfg")

	# If the file didn't load, ignore it.
	if err != OK:
		return

	# Iterate over all sections.
	for player in config.get_sections():
		# Fetch the data for each section.
		var player_name = config.get_value(player, "player_name")
		var player_score = config.get_value(player, "best_score")
		score_data[player_name] = player_score
