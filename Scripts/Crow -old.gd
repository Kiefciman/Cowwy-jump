extends RigidBody2D

var moods = ["landing", "flying", "eating", "pooping"]
var mood = ""
var t = 0
export var speed: int = 100
var direction = [-1, 1]
var z = 0
var hit = false
export var poop_scene: PackedScene
export var pooping_speed: int = 100
var can_poop = false
var apple_trees = []
var dist_to_nearest_apple_tree
var nearest_tree
var nearest_apple
onready var trees = get_node("/root/Level/trees/skinny")
onready var player = get_node("/root/Level/Player")
var target_found = false
var iddle = 0
var poop_time = 0

func _ready():
	mood = moods[1]
	self.linear_velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
	self.linear_velocity.y = (randi() & speed) / 2 * direction[randi() % 2 - 1]
	dist_to_nearest_apple_tree = 1000
	
func _integrate_forces(state):
	if self.linear_velocity.x < 2:
		if self.linear_velocity.x > -2:
			iddle += 1
			if iddle > 100:
#				print("a")
				self.linear_velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
				self.linear_velocity.y = (randi() % speed) / 2 * direction[randi() % 2 - 1]
				iddle = 0
#func _physics_process(delta):
	if mood == moods[0]:
		$AnimatedSprite.animation = "landed"
		self.gravity_scale = 2.5
	elif mood == moods[1]:
		$AnimatedSprite.animation = "flying"
		self.gravity_scale = 0
		t += 1
			
		if t >= randi() % 200 + 50:
			if self.global_position.x <= 1670 and self.global_position.x >= 60:
				self.linear_velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
			else:
				if self.global_position.x > 1670:
					self.linear_velocity.x = (randi() % speed + speed / 2) * -1 
				elif self.global_position.x < 60:
					self.linear_velocity.x = (randi() % speed + speed / 2)
			if self.global_position.y >= -500 and self.global_position.y <= -260:
				self.linear_velocity.y = (randi() % speed) / 2 * direction[randi() % 2 - 1]
			else:
				if self.global_position.y < -500:
					self.linear_velocity.y = (randi() % speed) / 2
				elif self.global_position.y > -260:
					self.linear_velocity.y = -(randi() % speed) / 2
			t = 0
					
	elif mood == moods[2]:
		for tree in trees.get_children():
			if tree.has_apples and tree.apples_amount > 0:
				if tree.global_position.y < -300:
#					self.linear_velocity = Vector2(0, 0)
					if self.global_position.distance_to(tree.global_position) < dist_to_nearest_apple_tree:
						dist_to_nearest_apple_tree = self.global_position.distance_to(tree.global_position)
						nearest_tree = tree
						if nearest_apple == null:
							if nearest_tree.global_position.x > self.global_position.x:
								self.linear_velocity.x = (randi() % speed + speed / 2)
							elif nearest_tree.global_position.x < self.global_position.x:
								self.linear_velocity.x = -(randi() % speed + speed / 2)
							else:
								self.linear_velocity.x = 0
							if nearest_tree.global_position.y > self.global_position.y:
								self.linear_velocity.y = (randi() % speed) / 2
							elif nearest_tree.global_position.y < self.global_position.y:
								self.linear_velocity.y = -(randi() % speed) / 2
							else:
								self.linear_velocity.y = 0
						else:
							nearest_apple.visible = false
							nearest_apple.queue_free()
							nearest_apple = null
							can_poop = true
							mood = moods[3]
							
	elif mood == moods[3] and !target_found:
		poop_time += 1
		if poop_time > 100:
			mood = moods[1]
		if player.global_position.x > self.global_position.x:
			self.linear_velocity.y = (randi() % speed) / 2
		elif player.global_position.x < self.global_position.x:
			self.linear_velocity.y = -(randi() % speed) / 2
		
	self.rotation_degrees = 0
	self.angular_velocity = 0
	
	if self.linear_velocity.x >= 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
func _physics_process(delta):
#	print(mood)
	if mood == moods[3]:
		var poop = poop_scene.instance()
		if $ass.get_child_count() == 0 and can_poop:
			if player.global_position.x > self.global_position.x - 5:
				if player.global_position.x < self.global_position.x + 5:
					target_found = true
					get_node("/root/Level").add_child(poop)
					poop.set_as_toplevel(true)
					poop.global_position = $ass.global_position
					can_poop = false
					target_found = false
					mood = moods[2]
	
func _on_Crow_body_entered(body):
	if body.is_in_group("objects"):
		if body.linear_velocity.x > 30 or body.linear_velocity.y > 30:
			if $AnimationPlayer.current_animation != "hit":
				$AnimationPlayer.current_animation = "hit"
			else:
				if $AnimationPlayer.get_current_animation_position() >= 1.0:
#					print($AnimationPlayer.get_current_animation_position())
					self.queue_free()
		if body.linear_velocity.x < -30 or body.linear_velocity.y < -30:
			if $AnimationPlayer.current_animation != "hit":
				$AnimationPlayer.current_animation = "hit"
			else:
				if $AnimationPlayer.get_current_animation_position() >= 1.0:
#					print($AnimationPlayer.get_current_animation_position())
					self.queue_free()


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		mood = moods[2]


func _on_Area2D_body_exited(body):
#	if body.is_in_group("player"):
#		mood = moods[1]
	pass


func _on_Area2D2_body_entered(body):
	if body.is_in_group("objects"):
		nearest_apple = body
