extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#pass
	if self.flip_h == false:
		if get_parent().get_parent().get_node("Player").global_position.x > self.global_position.x - 8 and get_parent().get_parent().get_node("Player").global_position.x < self.global_position.x + 8 and get_parent().get_parent().get_node("Player").global_position.y > self.global_position.y - 5:
				if get_parent().get_parent().get_node("Player/AnimatedSprite").flip_h == false: 
					self.rotation_degrees = -15
				if get_parent().get_parent().get_node("Player/AnimatedSprite").flip_h == true: 
					self.rotation_degrees = 15
		else:
			self.rotation_degrees = 0


