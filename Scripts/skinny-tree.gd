extends AnimatedSprite

export var apple_scene: PackedScene
var has_apples = false
var index = [0, 1]
var apples_amount
var apple_positions = []
var self_apples= []
var initial_position
var t = 0

func _ready():
	$AnimationPlayer.current_animation = "a"
	has_apples = index[randi() % 2]
	if has_apples:
		apples_amount = randi() % 5 + 1 
		for i in range(apples_amount):
			var apple = apple_scene.instance()
			$apples.add_child(apple)
		for apple_position in $apple_positions.get_children():
			apple_positions.append(apple_position)
		for self_apple in $apples.get_children():
			self_apples.append(self_apple)
			self_apple.linear_velocity = Vector2(0, 0)
			self_apple.gravity_scale = 0
			self_apple.z_index = 1
		for i in range(self_apples.size()):
			for j in range(apple_positions.size()):
				self_apples[i].position = apple_positions[i].position
				initial_position = self_apples[i].position.x

func _physics_process(delta):
	t += delta * 0.995
	$crown.material.set_shader_param("t", t)
	for self_apple in $apples.get_children():
		if self_apple.linear_velocity != Vector2(0, 0):
			self_apple.gravity_scale = 2.5
			var self_apple_position = self_apple.global_position
			$apples.remove_child(self_apple)
			var apple = apple_scene.instance()
			get_node("/root/Level/apples").add_child(apple)
			apple.global_position = self_apple_position
			apple.linear_velocity.y = 5
#		if self_apple.falling:
#			self_apple.gravity_scale = 2.5
#			var self_apple_position = self_apple.global_position
#			$apples.remove_child(self_apple)
#			var apple = apple_scene.instance()
#			get_node("/root/Level/apples").add_child(apple)
#			apple.global_position = self_apple_position
#			apple.linear_velocity.y = 5
#	for apple in $apples.get_children():
##		apple.position.x += 10* delta
##		print(apple.position.x)
##		var initial_position = apple.position.x
#		if apple.position.x < initial_position + 5:
#			apple.position.x += 10 * delta
#	for i in range(5):
#		$apples.position.x += 1
#	print($crown.material.get_shader_param("wind"))
