@tool
extends RichTextLabel

## matching the base size to the screen size to make text appear consistant on every monitor
@export var keep_text_size : bool = true

## Decides to use screen width or screen height to determine size
@export var use_height : bool = false

## percentage of screen to take up for font size
@export var base_size : float = 2.5

func _process(_delta):
	if keep_text_size:
		var v 
		if use_height:
			v = get_viewport_rect().size.y / 100
		else:
			v = get_viewport_rect().size.x / 100
		add_theme_font_size_override("normal_font_size", int(base_size * v))
