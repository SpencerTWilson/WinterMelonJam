extends Button

@export_file("*.tscn") var settings_scene_path: String
var settings_scene: Resource

func _ready() -> void:
	settings_scene = load(settings_scene_path)

func _pressed() -> void:
	get_tree().current_scene.add_child(settings_scene.instantiate())
