extends Node

class_name SoundManager

static var SOUND_EFFECTS: Dictionary = {}
static var audio_players: Dictionary = {}

const SOUNDS_CSV_PATH: String = "res://Resources/CSVs/sounds.csv"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SOUND_EFFECTS = CSVReader.load_resources_csv_to_dict(SOUNDS_CSV_PATH)
	__setup_audio_players()
		
func __setup_audio_players() -> void:
	for key in SOUND_EFFECTS.keys():
		var audio_player = AudioStreamPlayer.new()
		add_child(audio_player)
		audio_players[key] = audio_player
	
static func play(sound: String) -> void:
	assert(sound in SOUND_EFFECTS)
	
	if audio_players.has(sound):
		var player = audio_players[sound]
		player.stream = SOUND_EFFECTS[sound]
		
		player.play()
	else:
		printerr("Invalid Audio Player - Does not exist!")
