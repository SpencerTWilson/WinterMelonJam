extends TextureRect

@export var particles : GPUParticles2D
@export var anim : AnimationPlayer

func collect():
	anim.play("collect")

func splash():
	particles.restart()
