extends Node2D

#Formatted like:
#{"effect name": Node}
@export var effects: Dictionary = {}
#This will be full of the names of the VFX we want on
var active_effects: Array[String] = []

func _ready() -> void:
	pass
	#print(self)
	#for effect in effects:
		#effects[effect] = get_node(effects[effect])
	#
	#for effect in effects:
		#if active_effects.has(effect):
			#effects[effect].emitting = true
		#else :
			#effects[effect].emitting = false

#grabs the nodes so that the units can steal them hehe
func get_active_effects():
	var ret_effects: Array = []
	for effect in active_effects:
		ret_effects.append(effects[effect])
	return ret_effects
