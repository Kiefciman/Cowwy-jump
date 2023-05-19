extends RigidBody2D

onready var player = get_parent().get_node("Player")
export var max_x: int
export var max_y: int

func _ready():
	self.linear_velocity.x = (get_global_mouse_position().x - player.global_position.x) * 1.2
	self.linear_velocity.y = (get_global_mouse_position().y - player.global_position.y) * 2.5
	if self.linear_velocity.y < -max_y:
		self.linear_velocity.y = -max_y
	if self.linear_velocity.y > max_y:
		self.linear_velocity.y = max_y
	if self.linear_velocity.x < -max_x:
		self.linear_velocity.x = -max_x
	if self.linear_velocity.x > max_x:
		self.linear_velocity.x = max_x

#func _process(delta):
#	if self.linear_velocity.y < -210:
#		self.linear_velocity.y = 210
