extends Button

@export var settings_node: Node

func _pressed() -> void:
	get_tree().paused = false
	settings_node.queue_free()
