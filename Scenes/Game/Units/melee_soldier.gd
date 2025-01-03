extends Unit

@export var attack_sounds: Array

var collider

func _physics_process(delta: float) -> void:
	#movement
	if !blue_team: movement.x = -movement_speed
	else: movement.x = movement_speed
	movement.x *= delta

	#We save the collision into a var so any unit that needs that info can have it
	collision = move_and_collide(movement)
	
	if collision != null:
		collider = collision.get_collider()
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
				if collider._damage(attack_dmg):
					AudioManager._play_random_clip(attack_sounds, "SFX")
