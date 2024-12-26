@tool
extends RichTextLabel

## matching the base size to the screen size to make text appear consistant on every monitor
@export var keep_text_size : bool = true
@export var base_size : float = 2.5

func _process(delta):
	if keep_text_size:
		var vw = get_viewport_rect().size.x / 100
		add_theme_font_size_override("normal_font_size", int(base_size * vw))
