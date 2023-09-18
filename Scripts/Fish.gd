extends KinematicBody2D

var velocity: Vector2 = Vector2()
export var speed: int = 5

func _ready():
	velocity.x = speed

func _physics_process(delta):
	if is_on_wall():
		if !$Sprite.flip_h:
			velocity.x = -speed
			$Sprite.flip_h = true
			$CPUParticles2D.position.x = -8
		else:
			velocity.x = speed
			$Sprite.flip_h = false
			$CPUParticles2D.position.x = 8

	velocity = move_and_slide(velocity, Vector2.UP)
