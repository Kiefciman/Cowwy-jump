extends Node2D

func _ready():
	$AnimatedSprite.animation = "closed"
	$effects/Light2D.enabled = false
	$effects/Light2D2.enabled = false
	$effects/CPUParticles2D.emitting = false
	$effects/CPUParticles2D2.emitting = false

func _process(delta):
	if get_parent().get_node("Player").key_taken == true:
		$AnimatedSprite.animation = "opened"
		$effects/Light2D.enabled = true
		$effects/Light2D2.enabled = true
		$effects/CPUParticles2D.emitting = true
		$effects/CPUParticles2D2.emitting = true
