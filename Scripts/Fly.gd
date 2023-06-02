extends KinematicBody2D
export var base_speed: int
var destination: Vector2
var initial_position: Vector2
var t = 0
var index = [-1 , 1]
var direction_x = 0
var direction_y = 0
var speed: int
var velocity: Vector2 = Vector2()
var frog

func _ready():
	$AnimatedSprite.frame = randi() % 2
	$AnimatedSprite.speed_scale = rand_range(0.5, 1.5)

func _physics_process(delta):
	t += 1
	if t > 10:
		initial_position = self.position
		direction_y = index[randi() % 2]
		speed = randi() % 10 + 1
		if self.global_position.x > 10 and self.global_position.x < 1670: 
			direction_x = index[randi() % 2]
		else:
			if self.global_position.x < 10:
				direction_x = 1
			elif self.global_position.x > 1670:
				direction_x = -1
		if self.global_position.y < 60 and self.global_position.y > -450:
			direction_y = index[randi() % 2]
		else:
			if self.global_position.y > 60:
				direction_y = -1
			elif self.global_position.y < -450:
				direction_y = 1 
		velocity.x += base_speed * $AnimatedSprite.speed_scale * delta * direction_x * speed
		velocity.y += base_speed * $AnimatedSprite.speed_scale * delta * direction_y * speed
		t = 0
	
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	velocity = move_and_slide(velocity, Vector2.UP)
