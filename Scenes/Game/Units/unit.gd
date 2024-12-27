extends TeamObj
class_name Unit

@export var movement_speed: float = 0.5
var movement: Vector2 = Vector2.ZERO

var collision: KinematicCollision2D

@export var spawn_rate: float #Is period so number of seconds til a unit

func _ready() -> void:
	if !blue_team:
		set_collision_layer_value(1, false)
		set_collision_layer_value(2, true)
		
		set_collision_mask_value(1, true)
		set_collision_mask_value(2, false)
		
		primary_sprite.flip_h = true

func _physics_process(delta: float) -> void:
	#movement
	if !blue_team: movement.x = -movement_speed
	else: movement.x = movement_speed
	movement.x *= delta

	#We save the collision into a var so any unit that needs that info can have it
	collision = move_and_collide(movement)

func _on_death():
	queue_free()
