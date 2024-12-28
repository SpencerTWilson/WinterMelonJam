extends Button

@export_file("*.tscn") var settings_scene_path: String
@export var canvas_layer: CanvasLayer = null #This is only used if the scene root isn't a control node
var settings_scene: Resource

func _ready() -> void:
	settings_scene = load(settings_scene_path)

func _pressed() -> void:
	if canvas_layer == null:
		get_tree().current_scene.add_child(settings_scene.instantiate())
	else:
		canvas_layer.add_child(settings_scene.instantiate())
	get_tree().paused = true
