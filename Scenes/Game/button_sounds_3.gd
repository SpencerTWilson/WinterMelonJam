extends CanvasLayer


func _on_settings_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")


func _on_restart_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")
