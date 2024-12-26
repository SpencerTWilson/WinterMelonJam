extends Button

@export var settings_node: Node

func _pressed() -> void:
	settings_node.queue_free()
