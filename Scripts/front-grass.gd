extends Node2D

onready var player = get_parent().get_parent().get_parent().get_node("Player")
onready var player_sprite = get_parent().get_parent().get_parent().get_node("Player/AnimatedSprite")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	#pass
#	if self.flip_h == false:
	if player.global_position.x > self.global_position.x - 8:
		if player.global_position.x < self.global_position.x + 8:
			if not self.flip_v:
				if player.global_position.y - self.global_position.y > -1:
					if player.global_position.y - self.global_position.y < 1:
						if player_sprite.flip_h == false: 
							self.rotation_degrees = -15
						if player_sprite.flip_h == true: 
							self.rotation_degrees = 15
			else:
				if self.global_position.y - player.global_position.y > -4:
					if self.global_position.y - player.global_position.y < 4:
						if player_sprite.flip_h == false: 
							self.rotation_degrees = -15
						if player_sprite.flip_h == true: 
							self.rotation_degrees = 15
		else:
			self.rotation_degrees = 0
	else:
		self.rotation_degrees = 0


