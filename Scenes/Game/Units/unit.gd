extends CharacterBody2D

@export var blue_team: bool = false

@export var max_health: int = 5
var cur_health: int

@export var movement_speed: float = 0.5
var movement: Vector2 = Vector2.ZERO

func _physics_process(delta: float) -> void:
	if !blue_team: movement.x = -movement_speed
	var collision = move_and_collide(movement)
	pass
