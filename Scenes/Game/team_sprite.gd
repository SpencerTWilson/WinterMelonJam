extends Sprite2D

@export var blue_team_texture: Texture2D
@export var red_team_texture: Texture2D

func _ready() -> void:
	if get_parent().blue_team: texture = blue_team_texture
	else: texture = red_team_texture
