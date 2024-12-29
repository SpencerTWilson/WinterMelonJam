extends VBoxContainer



func _on_start_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")


func _on_settings_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")


func _on_quit_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")
