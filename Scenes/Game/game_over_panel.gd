extends Panel

func _exit_tree() -> void:
	get_tree().paused = false
