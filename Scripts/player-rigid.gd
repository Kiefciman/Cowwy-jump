extends KinematicBody2D

# Variables
export var initial_speed: int = 50
export var initial_jump: int = 200
export var gravity: int = 800
export var mass: int = 100
var velocity: Vector2 = Vector2()
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
var infinite_inertia = false
var jumping = 0
#var a = false
var t = 0

func pickup(target, item, distance = 20):
	if $face.global_position.distance_to(target.global_position) < distance:
		if Input.is_action_just_pressed("e"):
			target.queue_free()
#			var item = target_scene.instance()
#			self.add_child(item)
#			item.global_position = $face.global_position
			$item.texture = item
			
# Called when the node enters the scene tree for the first time.
func _ready():
	$item.texture = apple_texture
	$AnimatedSprite.animation = 'iddle'
#	$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
	
#	var speed = initial_speed + speed_upgrade

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
#	print(is_on_ceiling())
#	print("li ", left_entered, " lo ", left_exited, " ri ", right_entered, " ro ", right_exited)
	#$Camera2D.position = $Camera2D.position.round()
#	if get_global_mouse_position().x >= self.position.x:
	#$Camera2D.position.x = get_global_mouse_position().distance_to(self.position) * delta * 5
#	else:
#		$Camera2D.position.x = -get_global_mouse_position().distance_to(self.position) * delta * 5
#	if get_global_mouse_position().y <= self.position.y:
#		$Camera2D.position.y = -get_global_mouse_position().distance_to(self.position) * delta * 5
#	else:
#		$Camera2D.position.y = get_global_mouse_position().distance_to(self.position) * delta * 5
	#$Camera2D.position.x = lerp(self.position.x, get_global_mouse_position().distance_to(self.position) / 4, 0.3)
	$Camera2D.force_update_scroll()
	#$Camera2D.align()
	$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
	if !dead and !paused:
		var jump = initial_jump + jump_upgrade * 40
		var speed = initial_speed + speed_upgrade * 15

	# Reset horizontal velocity
#		velocity.x = 0

	# Gravity
		velocity.y += gravity * delta
#
		for i in get_slide_count():
			var slide_collision = get_slide_collision(i)
			if slide_collision and slide_collision.collider != null:
				if slide_collision.collider.is_in_group("objects"):
###					slide_collision.collider.disable_gravity()
##					slide_collision.collider.add_force(Vector2(0, 0), -slide_collision.normal * mass)
					if Input.is_action_just_pressed("space") and is_on_ceiling():
#						a = true
						slide_collision.collider.apply_central_impulse(Vector2(-slide_collision.normal.x * mass, -200))
						t += 1
#						if Input.is_action_pressed("jumpboost"):
#							velocity.y -= jump * delta * 60
#						else:
#							velocity.y -= initial_jump * delta * 60						
					else:
						slide_collision.collider.apply_central_impulse(Vector2(-slide_collision.normal.x * mass,0))# -dd Vector2(collision.collider.mass / 2, collision.collider.mass / 2))
##					slide_collision.collider.applied_force = slide_collision.normal * -1000
#				elif slide_collision.collider.is_in_group("animals"):
##					if self.global_position.x < collision.collider.global_position.x:
##						if Input.is_action_pressed("d"):
##							collision.collider.velocity.x = 10
##					slide_collision.collider.minus_gravity(-slide_collision.normal.y * delta * (mass - slide_collision.collider.mass) * 50)
##					slide_collision.collider.move_and_slide(-slide_collision.normal * delta * (mass - slide_collision.collider.mass) * 50)
##					slide_collision.collider.move_and_collide(-slide_collision.normal * delta * (mass - slide_collision.collider.mass))
#					slide_collision.collider.add_force(Vector2(0, 0), -slide_collision.normal * mass)
#
#		var collision = move_and_collide(velocity * delta)
#		if collision and collision.collider != null:
###			if collision.collider.is_in_group("animals"):
###				collision.collider.move_and_collide(velocity * delta)
#			if collision.collider.is_in_group("objects"):
#				if is_on_ceiling() and Input.is_action_just_pressed("space"):
#					collision.collider.apply_central_impulse(Vector2(collision.normal.x * mass, -200))
#				else:
#					collision.collider.apply_central_impulse(Vector2(-collision.normal.x * mass,0))
#				collision.collider.disable_gravity()
#				collision.collider.move_and_collide(-collision.normal * mass)

#		var collision = move_and_collide(velocity * delta)
#		if collision and collision.collider != null:
#			if collision.collider.is_in_group("animals"):
##				collision.collider.move_and_collide(velocity * delta)
##				collision.collider.velocity = velocity.length() * 0.5 * -collision.normal
##				velocity = velocity.bounce(collision.normal) * 0.5
#				if self.global_position.x < collision.collider.global_position.x:
#					if Input.is_action_pressed("d"):
#						collision.collider.velocity.x = 10
		
		if t >= 10:
			print(t)
			velocity.y -= 500
			t = 0

		if velocity.y < 0:
			jumping = 1
#		elif velocity.y > 0:
#			jumping = -1
		else:
			jumping = 0
#		print(is_on_ceiling())

		if Input.is_action_pressed("a") and !Input.is_action_pressed("d"):
			if Input.is_action_pressed("speed") and speed_upgrade > 0:
				velocity.x = -speed
			else:
				if velocity.x > -30:
					velocity.x = -30
				if velocity.x >= -initial_speed:
					velocity.x -= (initial_speed / 0.5) * delta
				else:
					velocity.x = -initial_speed
#					velocity.x = -initial_speed
#				velocity.x = lerp(velocity.x, -initial_speed, 1.5)
#				velocity.x = min(velocity.x - 0.1, -initial_speed)
			$AnimatedSprite.flip_h = true
#			$Camera2D.position.x = -56
		elif Input.is_action_pressed("d") and !Input.is_action_pressed("a"):
			if Input.is_action_pressed("speed") and speed_upgrade > 0:
				velocity.x = speed
			else:
				if velocity.x < 30:
					velocity.x = 30
				if velocity.x <= initial_speed:
					velocity.x += (initial_speed / 0.5) * delta
				else:
					velocity.x = initial_speed
#				velocity.x = lerp(velocity.x, initial_speed, 1.5)
#				velocity.x = max(velocity.x + 0.1, initial_speed)
			$AnimatedSprite.flip_h = false
#			$Camera2D.position.x = 56
		else:
			velocity.x *= 0.95
			if $AnimatedSprite.flip_h == false:
				if velocity.x < initial_speed / 1.5:
					velocity.x = 0
			if $AnimatedSprite.flip_h == true:
				if -velocity.x < initial_speed / 1.5:
					velocity.x = 0
		if Input.is_action_just_pressed("space") and is_on_floor():# and not a:
			if Input.is_action_pressed("jumpboost"):
				velocity.y -= jump * delta * 60
			else:
				velocity.y -= initial_jump * delta * 60
		
#		if $AnimatedSprite.flip_h == false and is_on_floor():
#			if Input.is_action_pressed("d") == false:
#				velocity.x += initial_speed / 10

		if Input.is_action_just_released("scroll_up"):
			$Camera2D.zoom -= Vector2(0.1, 0.1)
			print($Camera2D.zoom)
		if Input.is_action_just_released("scroll_down") and $Camera2D.zoom <= Vector2(1.2, 1.2):
			$Camera2D.zoom += Vector2(0.1, 0.1)
			print($Camera2D.zoom)
			
	# Apply the velocity
#		velocity.x = velocity.x * 70 * delta
		velocity = move_and_slide(velocity, Vector2.UP, false, 10, PI/4, infinite_inertia)
#		move_and_collide(velocity, infinite_inertia, true, false)
#		print("velocity.x = ", velocity.x)
		
	# Changing the Animation
		if !underwater:
			if velocity.x != 0:
				$AnimatedSprite.animation = 'running'
			elif velocity.x == 0:
				$AnimatedSprite.animation = 'iddle'
		if underwater:
#			$UI/butthole_capacity/Panel/ProgressBar.value += 0.04
			butthole_capacity += 0.04
			if velocity.x != 0:
				$AnimatedSprite.animation = 'running_underwater'
			elif velocity.x == 0:
				$AnimatedSprite.animation = 'iddle_underwater'

		if $UI/butthole_capacity/Panel/ProgressBar.value == 100:
			dead = true
			
		if dead == true:
			$UI/u_ded_lol.visible = true
			$UI/butthole_capacity.visible = false
			
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
			
		if $AnimatedSprite.flip_h == true:
			$item.position.x = -10
			$item .flip_h = true
		else:
			$item.position.x = 8
			$item.flip_h = false
			
		for apple in get_node("/root/Level/apples").get_children():
			pickup(apple, apple_texture)
			
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
