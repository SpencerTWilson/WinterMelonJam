extends Timer

var unit: Unit
var unit_scene: PackedScene

func _ready() -> void:
	var temp_unit = unit_scene.instantiate()
	unit = temp_unit
	wait_time = unit.spawn_rate * get_parent().spawn_rate
	temp_unit.queue_free()

func _on_timeout() -> void:
	var new_unit: Unit = unit_scene.instantiate()
	new_unit.blue_team = get_parent().blue_team
	add_sibling(new_unit) #set the parent to our parent cause we don't have a position.
