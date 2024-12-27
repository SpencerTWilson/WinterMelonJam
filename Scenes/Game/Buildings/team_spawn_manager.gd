extends Node2D

@export var blue_team: bool = false
var spawner: PackedScene = preload("res://Scenes/Game/Buildings/spawner.tscn")

#Global spawn rate 1 is normal speed 0.5 is 2x speed
var spawn_rate: float = 1

#spawn rate is individual so bigger units come out slower
#{UnitScene: Timer}
var unlocked_units: Dictionary = {}

func _process(_delta: float) -> void:
	for unit in unlocked_units:
		if unlocked_units[unit] == null:
			var new_spawner = spawner.instantiate()
			new_spawner.unit_scene = unit
			add_child(new_spawner)
			unlocked_units[unit] = new_spawner
