extends Node2D

func _ready():
	$AnimatedSprite.animation = "closed"
	$effects/CPUParticles2D.emitting = false
	$effects/CPUParticles2D2.emitting = false

func _process(delta):
	if get_parent().get_node("Player").key_taken == true:
		$AnimatedSprite.animation = "opened"
		$effects/CPUParticles2D.emitting = true
		$effects/CPUParticles2D2.emitting = true
