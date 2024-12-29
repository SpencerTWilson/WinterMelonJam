extends Panel

@export var music: AudioStream

func _ready() -> void:
	AudioManager._stop_music()
	AudioManager._play_music(music)
