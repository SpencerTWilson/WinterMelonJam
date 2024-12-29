extends Node2D

#Formatted like:
#{"effect name": Node}
@export var effects: Array[GPUParticles2D]
#This will be full of the names of the VFX we want on
var active_effects: Array[String] = []

func _ready() -> void:
	_card_types_to_effects()
	
	for effect in effects:
		if active_effects.has(effect.name.to_lower()):
			effect.emitting = true
		else :
			effect.emitting = false

func _card_types_to_effects():
	for type in $"..".tags:
		for effect in effects:
			if effect.name.to_lower() == type:
				active_effects.append(type)
		
#grabs the nodes so that the units can steal them hehe
func get_active_effects():
	var ret_effects: Array = []
	for effect in active_effects:
		ret_effects.append(effect)
	return ret_effects
