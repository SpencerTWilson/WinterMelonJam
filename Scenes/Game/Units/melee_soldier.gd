extends Unit

@export var attack_sounds: Array
@export var death_sounds: Array

var collider

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if collision != null:
		collider = collision.get_collider()
	#If we collided with an opposing team obj
	if collider != null and collider is TeamObj and !dead:
		if collider.blue_team != blue_team:
			#If our attack isn't on cooldown
			if attack_timer.time_left == 0:
				attack_timer.start()
				if collider._damage(attack_dmg):
					AudioManager._play_random_clip(attack_sounds, "SFX")

func _on_death():
	super._on_death()
	AudioManager._play_random_clip(death_sounds, "SFX")
