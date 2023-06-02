extends RigidBody2D

export var base_speed: int = 100
export var base_jump: int = 150
var speed_upgrade = 0
var jump_upgrade = 0
var butthole_capacity = 0
var dead = false
var underwater = false
var key_taken = false
var paused = false
var jump_failed = false
var left_entered = false
var left_exited = false
var right_entered = false
var right_exited = false
export var apple_scene: PackedScene
export var apple_texture: Resource
var can_go_right = true
var can_go_left = true

func pickup(target, item, distance = 20):
	if $face.global_position.distance_to(target.global_position) < distance:
		if Input.is_action_just_pressed("e"):
			target.queue_free()
			$item.texture = item

func _ready():
	$item.texture = apple_texture
	$AnimatedSprite.animation = 'iddle'
	
func _integrate_forces(state):
	if !dead and !paused:
		var jump = base_jump + jump_upgrade * 50
		var speed = base_speed + speed_upgrade * 15
		
		if Input.is_action_pressed("a") and !Input.is_action_pressed("d") and can_go_left:
			if Input.is_action_pressed("speed") and speed_upgrade > 0:
				self.linear_velocity.x = -speed
			else:
				self.linear_velocity.x = -base_speed
			$AnimatedSprite.flip_h = true
				
		if Input.is_action_pressed("d") and !Input.is_action_pressed("a") and can_go_right:
			if Input.is_action_pressed("speed") and speed_upgrade > 0:
				self.linear_velocity.x = speed
			else:
				self.linear_velocity.x = base_speed
			$AnimatedSprite.flip_h = false
				
		if Input.is_action_just_pressed("space"):
			#if self.linear_velocity.y > -10 or self.linear_velocity.y < 10:
			if Input.is_action_pressed("jumpboost"):
				self.linear_velocity.y = -jump
			else:
				self.linear_velocity.y = -base_jump
		self.angular_velocity = 0
		self.rotation_degrees = 0

#func _physics_process(delta):
		$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
		if !dead and !paused:

			if Input.is_action_just_released("scroll_up"):
				$Camera2D.zoom -= Vector2(0.1, 0.1)
			if Input.is_action_just_released("scroll_down") and $Camera2D.zoom <= Vector2(1.2, 1.2):
				$Camera2D.zoom += Vector2(0.1, 0.1)
			
			if !underwater:
				if self.linear_velocity.x != 0:
					$AnimatedSprite.animation = 'running'
				elif self.linear_velocity.x == 0:
					$AnimatedSprite.animation = 'iddle'
			if underwater:
				butthole_capacity += 0.04
				if self.linear_velocity.x != 0:
					$AnimatedSprite.animation = 'running_underwater'
				elif self.linear_velocity.x == 0:
					$AnimatedSprite.animation = 'iddle_underwater'

		if $UI/butthole_capacity/Panel/ProgressBar.value == 100:
			dead = true
			
		if dead == true:
			$UI/u_ded_lol.visible = true
			$UI/butthole_capacity.visible = false
			
			
		if $AnimatedSprite.flip_h == true:
			$item.position.x = -10
			$item .flip_h = true
		else:
			$item.position.x = 8
			$item.flip_h = false
			
		for apple in get_node("/root/Level/apples").get_children():
			pickup(apple, apple_texture)
			
func _physics_process(delta):
#	$Camera2D.force_update_scroll()
	if Input.is_action_just_pressed("shoot"):
		if $item.texture == apple_texture:
			$item.texture = null
			var apple = apple_scene.instance()
			get_node("/root/Level/apples").add_child(apple)
			apple.remove_from_group("objects")
			apple.set_as_toplevel(true)
			apple.global_position = $item.global_position
			apple.linear_velocity.x = (get_global_mouse_position().x - self.global_position.x) * 1.2
			apple.linear_velocity.y = (get_global_mouse_position().y - self.global_position.y) * 2.5
			if apple.linear_velocity.y < -210:
				apple.linear_velocity.y = -210
			if apple.linear_velocity.y > 210:
				apple.linear_velocity.y = 210
			if apple.linear_velocity.x < -140:
				apple.linear_velocity.x = -140
			if apple.linear_velocity.x > 140:
				apple.linear_velocity.x = 140
#				if apple.linear_velocity > Vector2(0, 0):
			apple.add_to_group("objects")
#	print(mass)
#	if $RayCast2D.is_colliding():
#		print($RayCast2D.get_collider().get_class())
			
func _on_Area2D_area_entered(area):
	get_parent().get_node("jump_carrot").queue_free()
	jump_upgrade += 1
	
func _on_water_area_area_entered(area):
	$UI/butthole_capacity.visible = true
	underwater = true
	jump_failed = true
	left_entered = false
	left_exited = false
	right_entered = false
	right_exited = false
	get_parent().get_node("help_panels/challenge").combination = 0
	get_parent().get_node("help_panels/challenge").combination_bak = 0

func _on_water_area_area_exited(area):
	$UI/butthole_capacity.visible = false
	underwater = false
	jump_failed = false

func _on_speed_carrot_area_entered(area):
	get_parent().get_node("speed_carrot").queue_free()
	speed_upgrade += 1


func _on_key_area_entered(area):
	get_parent().get_node("key").queue_free()
	key_taken = true


func _on_door_area_entered(area):
	if key_taken == true:
		get_parent().level += 1
		get_tree().quit()


func _on_challenge_activation_area_entered(area):
	if get_parent().get_node("help_panels/challenge_activator").challenge_accepted == false:
		get_parent().get_node("help_panels/challenge_activator/Panel").visible = true
	else:
		get_parent().get_node("help_panels/challenge_activator/Panel2").visible = true
	

func _on_challenge_activation_area_exited(area):
	get_parent().get_node("help_panels/challenge_activator/Panel").visible = false
	get_parent().get_node("help_panels/challenge_activator/Panel2").visible = false



func _on_challenge_area_entered(area):
	get_parent().get_node("help_panels/challenge/Panel1").visible = true
#	if Input.is_action_pressed("f"):
#		get_parent().get_node("help_panels/challenge/Panel").visible = false
#		get_parent().get_node("help_panels/challenge/Panel2").visible = true
	left_entered = true
	left_exited = false
	if right_exited and left_entered:
		get_parent().get_node("help_panels/challenge").combination = 2
		if get_parent().get_node("help_panels/challenge").combination != get_parent().get_node("help_panels/challenge").combination_bak:
			get_parent().get_node("help_panels/challenge").score += 1

func _on_challenge_area_exited(area):
	get_parent().get_node("help_panels/challenge/Panel1").visible = false
	get_parent().get_node("help_panels/challenge/Panel2").visible = false
	left_exited = true
	left_entered = false
	if left_exited and right_exited:
		get_parent().get_node("help_panels/challenge").combination_bak = get_parent().get_node("help_panels/challenge").combination

func _on_jump_area_entered(area):
	right_entered = true
	right_exited = false
	if left_exited and right_entered:
		get_parent().get_node("help_panels/challenge").combination = 1
		if get_parent().get_node("help_panels/challenge").combination != get_parent().get_node("help_panels/challenge").combination_bak:
			get_parent().get_node("help_panels/challenge").score += 1

func _on_jump_area_exited(area):
	right_exited = true
	right_entered = false
	if right_exited and left_exited:
		get_parent().get_node("help_panels/challenge").combination_bak = get_parent().get_node("help_panels/challenge").combination

func _on_finished_area_entered(area):
	if get_parent().get_node("help_panels/challenge").score == 5:
		get_parent().get_node("help_panels/challenge").finished = true

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
