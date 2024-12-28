extends TextureRect

@export var particles : GPUParticles2D
@export var anim : AnimationPlayer
@export var jank : Node2D

func collect():
	anim.play("Collect")

func splash():
	particles.restart()

func _process(_delta):
	position.y = jank.position.y
