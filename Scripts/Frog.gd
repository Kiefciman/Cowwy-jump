extends RigidBody2D

export var jump: int
export var speed: int
var t = 0
var t_mod: int
var t_plus_min: int
var index = [-1, 1]
var jump_mod: int
var speed_mod: int
var direction: int
var jump_plus_minus: int
var speed_plus_minus: int

func _ready():
	t_mod = randi() % 100 + 1
	t_plus_min = index[randi() % 2]
#
func _physics_process(delta):
	t += 1
	if t >= 200 + t_plus_min * t_mod:
		speed_plus_minus = index[randi() % 2]
		jump_plus_minus = index[randi() % 2]
		speed_mod = randi() % 11 * speed_plus_minus
		jump_mod = randi() % 51 * jump_plus_minus
		if self.global_position.x > 40:
			direction = randi() % 3 - 1
		else:
			direction = 1
		if direction != 0:
			self.linear_velocity.y = -jump + jump_mod
			self.linear_velocity.x = speed * direction + speed_mod
		t_mod = randi() % 100 + 1
		t_plus_min = index[randi() % 2]
		t = 0
	self.angular_velocity = 0
	self.rotation_degrees = 0
