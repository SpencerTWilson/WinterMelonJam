extends VBoxContainer


func _on_back_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")


func _on_left_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")


func _on_right_button_pressed() -> void:
	AudioManager._play_clip(AudioManager.button_sound, "UI")
