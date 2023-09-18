extends KinematicBody2D

var moods = ["landing", "flying", "eating", "pooping"]
var mood = ""
export var speed: int = 100
var direction = [-1, 1]
var z = 0
var hit = false
export var poop_scene: PackedScene
export var pooping_speed: int = 200
var can_poop = true
var apple_trees = []
var dist_to_nearest_apple_tree
var nearest_tree
var nearest_apple = null
onready var player = get_node("/root/Level/Player")
var target_found = false
var iddle = 0
var poop_time = 0
var velocity: Vector2 = Vector2()
export var gravity: int = 100
var t = 0
export var poop_gravity:int = 100
var cracra_finished = true

func _ready():
	mood = moods[1]
	velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
	velocity.y = (randi() & speed) / 2 * direction[randi() % 2 - 1]
	dist_to_nearest_apple_tree = 1000
	
#func _integrate_forces(state):
#	if self.linear_velocity.x < 2:
#		if self.linear_velocity.x > -2:
#			iddle += 1
#			if iddle > 100:
##				print("a")
#				self.linear_velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
#				self.linear_velocity.y = (randi() % speed) / 2 * direction[randi() % 2 - 1]
#				iddle = 0
#
#	elif mood == moods[3] and !target_found:
#		poop_time += 1
#		if poop_time > 100:
#			mood = moods[1]
#		if player.global_position.x > self.global_position.x:
#			self.linear_velocity.y = (randi() % speed) / 2
#		elif player.global_position.x < self.global_position.x:
#			self.linear_velocity.y = -(randi() % speed) / 2
#
func _physics_process(delta):
	if mood == moods[0]:
		$AnimatedSprite.animation = "landed"
		
	elif mood == moods[1]:
		t += 1
		$AnimatedSprite.animation = "flying"
		if t >= randi() % 200 + 40:
			t = 0
			if self.global_position.x <= 1670 and self.global_position.x >= 60:
				velocity.x = (randi() % speed + speed / 2) * direction[randi() % 2 - 1]
			else:
				if self.global_position.x > 1670:
					velocity.x = (randi() % speed + speed / 2) * -1 
				elif self.global_position.x < 60:
					velocity.x = (randi() % speed + speed / 2)
			if self.global_position.y >= -500 and self.global_position.y <= -260:
				velocity.y = (randi() % speed) / 2 * direction[randi() % 2 - 1]
			else:
				if self.global_position.y < -500:
					velocity.y = (randi() % speed) / 2
				elif self.global_position.y > -260:
					velocity.y = -(randi() % speed) / 2
					
#	elif mood == moods[2]:
#		var trees = get_node("/root/Level/trees/skinny")
#		for tree in trees.get_children():
#			if tree.get_node("apples").get_child_count() > 0:
#				if tree.global_position.y < -300:
#					if self.global_position.distance_to(tree.global_position) < dist_to_nearest_apple_tree:
#						dist_to_nearest_apple_tree = self.global_position.distance_to(tree.global_position)
#						nearest_tree = tree
#						velocity = Vector2(0, 0)
#						if nearest_tree.global_position.x - self.global_position.x < 10 or self.global_position.x - nearest_tree.global_position.x < 10:
#							velocity.x = 0
#						else:
#							if nearest_tree.global_position.x > self.global_position.x:
#								velocity.x = (randi() % speed + speed / 2)
#							elif nearest_tree.global_position.x < self.global_position.x:
#								velocity.x = -(randi() % speed + speed / 2)
#						else:
#							velocity.x = 0
#						if nearest_tree.global_position.y > self.global_position.y:
#							velocity.y = (randi() % speed) / 2
#						elif nearest_tree.global_position.y < self.global_position.y:
#							velocity.y = -(randi() % speed) / 2
#						else:
#							print("y0")
#							velocity.y = 0
#						if nearest_apple == null:
#						elif nearest_apple != null:
#							nearest_apple.visible = false
#							nearest_apple.queue_free()
#							nearest_apple = null
#							can_poop = true
#							velocity = Vector2(0, 0)
#							mood = moods[3]
							
	elif mood == moods[3]:
		if cracra_finished:
				cracra_finished = false
				$AudioStreamPlayer2D.play()
#		if !target_found:
#	#		poop_time += 1
#	#		if poop_time > 100:
#	#			mood = moods[1]
#			if player.global_position.x > self.global_position.x:
#				velocity.y = (randi() % speed) / 2
#			elif player.global_position.x < self.global_position.x:
#				velocity.y = -(randi() % speed) / 2
#		else:
		var poop = poop_scene.instance()
		if $ass.get_child_count() == 0 and can_poop:
			if player.global_position.x > self.global_position.x - 5:
				if player.global_position.x < self.global_position.x + 5:
#					velocity = Vector2(0, 0)
#					target_found = true
					get_node("/root/Level").add_child(poop)
					poop.global_position = $ass.global_position + Vector2(0, 10)
					poop.set_as_toplevel(true)
					poop.gravity = poop_gravity
#						can_poop = false
					target_found = false
					mood = moods[1]

	if velocity.x > 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false
	
	for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider != null and collision.collider.get_class() != "TileMap":
				if collision.collider.is_in_group("rock"):
					if collision.collider.linear_velocity.x > 10 or collision.collider.linear_velocity.y > 10:
						if $AnimationPlayer.current_animation != "hit":
							$AnimationPlayer.current_animation = "hit"
						else:
							if $AnimationPlayer.get_current_animation_position() >= 1.0:
			#					print($AnimationPlayer.get_current_animation_position())
								self.queue_free()
					if collision.collider.linear_velocity.x < -10 or collision.collider.linear_velocity.y < -10:
						if $AnimationPlayer.current_animation != "hit":
							$AnimationPlayer.current_animation = "hit"
						else:
							if $AnimationPlayer.get_current_animation_position() >= 1.0:
			#					print($AnimationPlayer.get_current_animation_position())
								self.queue_free()

	velocity = move_and_slide(velocity, Vector2.UP, false, 1, 0.785398, false)

func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		mood = moods[3]

func _on_Area2D_body_exited(body):
#	if body.is_in_group("player"):
#		mood = moods[1]
	pass

func _on_Area2D2_body_entered(body):
#	if body.is_in_group("objects"):
#		nearest_apple = body
	pass

func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.stop()
	cracra_finished = true
