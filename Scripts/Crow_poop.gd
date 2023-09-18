extends KinematicBody2D

var velocity: Vector2 = Vector2()
var gravity = 0

func _physics_process(delta):
	
	velocity.y += gravity
	
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		if collision.collider != null:
#			if !collision.collider.get_class() == "KinematicBody2D":
#				self.queue_free()
	
	velocity = move_and_slide(velocity, Vector2.UP, false, 4, 0.785398, false)
