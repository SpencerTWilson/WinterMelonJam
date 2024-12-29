extends Panel

@export var music: AudioStream

func _ready() -> void:
	AudioManager._play_music(music)
