extends Unit

@export var attack_timer: Timer
@export var attack_dmg: float

var collider

func _physics_process(delta: float) -> void:
	super._physics_process(delta)
	
	if collision != null:
		collider = collision.get_collider()
	#If we collided with an opposing team obj
	if collider != null and collider is TeamObj:
		if collider.blue_team != blue_team:
			#If our attack isn't on cooldown
			if attack_timer.time_left == 0:
				attack_timer.start()
				collider._damage(attack_dmg)
