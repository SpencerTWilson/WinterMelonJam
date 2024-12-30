extends GridContainer

@export var blue_team = false

var units_unlocked: Array[bool] = [true,false,false,false,false]
@export var unit_pics: Array[TextureRect]

func _ready() -> void:
	_update()

func _update():
	var i = 0
	for unit in units_unlocked:
		if unit: unit_pics[i]._update()
		i += 1
