extends Unit

@export var attack_sounds: Array

@export var bullet: PackedScene

var collider

func _ready() -> void:
	super._ready()
	if blue_team:
		$RayCast2D.set_collision_mask_value(1, false)
		$RayCast2D.set_collision_mask_value(2, true)
		$RayCast2D.target_position = Vector2(150,0)

func _physics_process(delta: float) -> void:
	#movement
	if !$RayCast2D.is_colliding():
		if !blue_team: movement.x = -movement_speed
		else: movement.x = movement_speed
		movement.x *= delta
		move_and_collide(movement)
	else:
		collider = $RayCast2D.get_collider()
		#If we collided with an opposing team obj
		if collider != null and collider is TeamObj: #and !dead:
			if collider.blue_team != blue_team:
				#make sure we haven't died too long ago A little leinency is here cause otherwise physics engine favors blue
				if death_anim_timer != null:
					if death_anim_timer.time_left <= 0.49:
						return
				
				#If our attack isn't on cooldown
				if attack_timer.time_left == 0:
					attack_timer.start()
					_create_bullet()
					if collider._damage(attack_dmg):
						AudioManager._play_random_clip(attack_sounds, "SFX")

func _create_bullet():
	var new_bullet = bullet.instantiate()
	new_bullet.target = collider
	add_child(new_bullet)
