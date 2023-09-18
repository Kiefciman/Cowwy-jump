extends RigidBody2D

export var base_speed: int = 55
export var base_jump: int = 140
var speed_upgrade = 0
var jump_upgrade = 0
var butthole_capacity = 0
var dead = false
var underwater = false
var key_taken = false
#var key = false
var paused = false
var left_entered = false
var left_exited = false
var right_entered = false
var right_exited = false
export var apple_scene: PackedScene
export var apple_texture: Resource
export var rock_scene: PackedScene
export var rock_texture: Resource
var can_go_right = true
var can_go_left = true
var can_go = true
var can_jump = false
var apples_eaten = 0
export var music1: Resource
export var music2: Resource
export var music3: Resource
export var music4: Resource
export var music5: Resource
export var music6: Resource
export var music7: Resource
export var music8: Resource
export var music9: Resource
export var music10: Resource
export var music11: Resource
var music_index = 0
var musics = []
var current_music

func throw(item):
	$item.texture = null
	item.set_as_toplevel(true)
	item.global_position = $item.global_position
	item.linear_velocity.x = (get_global_mouse_position().x - self.global_position.x) * 1.2
	item.linear_velocity.y = (get_global_mouse_position().y - self.global_position.y) * 2.5 # 2.5
	if item.linear_velocity.y < -250:
		item.linear_velocity.y = -250
	if item.linear_velocity.y > 250:
		item.linear_velocity.y = 250
	if item.linear_velocity.x < -100:
		item.linear_velocity.x = -100
	if item.linear_velocity.x > 100:
		item.linear_velocity.x = 100

func pickup(target, item, distance = 20):
	if $item.texture == null and $face.global_position.distance_to(target.global_position) < distance:
		if Input.is_action_just_pressed("e"):
			target.queue_free()
			$item.texture = item

func _ready():
	$item.texture = null
	$AnimatedSprite.animation = 'iddle'
	musics = [music1, music2, music3, music4, music5, music6, music7, music8, music9, music10, music11]
	current_music = musics[music_index]
	$AudioStreamPlayer2D.stream = current_music
	$AudioStreamPlayer2D.play()
	
func _integrate_forces(state):
	if !dead and !paused:
		var jump = base_jump + jump_upgrade * 50
		var speed = base_speed + speed_upgrade * 15
		
#		if self.linear_velocity.y < 1 or self.linear_velocity.y > -1:
#			can_jump = true
#		else:
#			can_jump = false
		
		if Input.is_action_pressed("a") and !Input.is_action_pressed("d"):
			if can_go_left:
				if Input.is_action_pressed("speed") and speed_upgrade > 0:
					self.linear_velocity.x = -speed
				else:
					self.linear_velocity.x = -base_speed
			$AnimatedSprite.flip_h = true
				
		if Input.is_action_pressed("d") and !Input.is_action_pressed("a"):
			if can_go_right:
				if Input.is_action_pressed("speed") and speed_upgrade > 0:
					self.linear_velocity.x = speed
				else:
					self.linear_velocity.x = base_speed
			$AnimatedSprite.flip_h = false
				
		if Input.is_action_just_pressed("space") and can_jump:# and can_jump:
#			if self.linear_velocity.y > -5 and self.linear_velocity.y < 5:
#			print(self.linear_velocity.y)
			if Input.is_action_pressed("jumpboost"):
				self.linear_velocity.y = -jump
			else:
				self.linear_velocity.y = -base_jump
		self.angular_velocity = 0
		self.rotation_degrees = 0

		$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
#		if !dead and !paused:

		if Input.is_action_just_released("scroll_up"):
			$Camera2D.zoom -= Vector2(0.1, 0.1)
		if Input.is_action_just_released("scroll_down") and $Camera2D.zoom <= Vector2(1.2, 1.2):
			$Camera2D.zoom += Vector2(0.1, 0.1)
		
		if !underwater:
			if self.linear_velocity.x > 10 or self.linear_velocity.x < -10:
				$AnimatedSprite.animation = 'running'
			else:
				$AnimatedSprite.animation = 'iddle'
		if underwater:
			butthole_capacity += 0.04
			if self.linear_velocity.x > 10 or self.linear_velocity.x < -10:
				$AnimatedSprite.animation = 'running_underwater'
			else:
				$AnimatedSprite.animation = 'iddle_underwater'

		if $UI/butthole_capacity/Panel/ProgressBar.value == 100:
			dead = true
			
		if $AnimatedSprite.flip_h == true:
			$item.position.x = -10
			$item .flip_h = true
		else:
			$item.position.x = 8
			$item.flip_h = false
			
	if dead == true:
		$UI/u_ded_lol.visible = true
		$UI/butthole_capacity.visible = false
			
	self.rotation_degrees = 0
	self.angular_velocity = 0
			
func _physics_process(delta):
	for apple in get_node("/root/Level/apples").get_children():
		pickup(apple, apple_texture)
		
	for rock in get_node("/root/Level/rocks").get_children():
		pickup(rock, rock_texture)
		
#	$Camera2D.force_update_scroll()
	if Input.is_action_just_pressed("throw"):
		if $item.texture == apple_texture:
			var apple = apple_scene.instance()
			get_node("/root/Level/apples").add_child(apple)
			throw(apple)
		elif $item.texture == rock_texture:
			var rock = rock_scene.instance()
			get_node("/root/Level/rocks").add_child(rock)
			throw(rock)
	
	if Input.is_action_just_pressed("g"):
		if $item.texture == apple_texture:
			apples_eaten += 1
			print(apples_eaten)
			$item.texture = null
			
func _on_Area2D_area_entered(area):
	get_parent().get_node("jump_carrot").queue_free()
	jump_upgrade += 1

func _on_speed_carrot_area_entered(area):
	get_parent().get_node("speed_carrot").queue_free()
	speed_upgrade += 1

func _on_challenge_activation_area_entered(area):
	get_parent().get_node("help_panels/challenge_activator/Panel").visible = true

func _on_challenge_activation_area_exited(area):
	get_parent().get_node("help_panels/challenge_activator/Panel").visible = false
	get_parent().get_node("help_panels/challenge_activator/Panel2").visible = false

func _on_help_area_entered(area):
	get_parent().get_node("help_panels/help_panel_1/Panel").visible = true

func _on_help_area_exited(area):
	get_parent().get_node("help_panels/help_panel_1/Panel2").visible = false
	get_parent().get_node("help_panels/help_panel_1/Panel").visible = false

func _on_right_body_entered(body):
	if body.get_class() == "TileMap":
		can_go_right = false
		self.linear_velocity.x = 0

func _on_right_body_exited(body):
	if body.get_class() == "TileMap":
		can_go_right = true

func _on_left_body_entered(body):
	if body.get_class() == "TileMap":
		can_go_left = false
		self.linear_velocity.x = 0

func _on_left_body_exited(body):
	if body.get_class() == "TileMap":
		can_go_left = true


func _on_Area2D_body_entered(body):
	if body.get_class() == "TileMap":
		can_go = false
	elif body.is_in_group("damage"):
		body.queue_free()
		if $AnimationPlayer.current_animation == "hit":
			dead = true
		else:
			$AnimationPlayer.current_animation = "hit"

func _on_Area2D_body_exited(body):
	if body.get_class() == "TileMap":
		can_go = true

#func _on_Player_body_entered(body):
#	can_jump = true
#
#func _on_Player_body_exited(body):
#	can_jump = false

func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.stop()
	music_index += 1
	$AudioStreamPlayer2D.stream = current_music
	$AudioStreamPlayer2D.play()


func _on_Player_body_entered(body):
	if body != null:
		can_jump = true

func _on_Player_body_exited(body):
	if body != null:
		can_jump = false
