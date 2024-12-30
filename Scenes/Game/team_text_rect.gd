extends TextureRect

@export var blue_team_texture: Texture2D
@export var red_team_texture: Texture2D

func _update() -> void:
	if get_parent().blue_team: texture = blue_team_texture
	else: texture = red_team_texture
