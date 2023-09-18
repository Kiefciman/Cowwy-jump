extends Node2D

func _ready():
	$AnimatedSprite.animation = "closed"
	$effects/CPUParticles2D.emitting = false
	$effects/CPUParticles2D2.emitting = false

func _process(delta):
	if get_parent().get_node("Player").key_taken:
#	if get_parent().get_node("Player").key:
		$AnimatedSprite.animation = "opened"
		$effects/CPUParticles2D.emitting = true
		$effects/CPUParticles2D2.emitting = true

func _on_door_body_entered(body):
	if $AnimatedSprite.animation == "opened":
		if body.is_in_group("player"):
			get_parent().level += 1
			get_tree().quit()
