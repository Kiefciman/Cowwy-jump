extends KinematicBody2D

# Variables
export var initial_speed: int
export var initial_jump: int
export var gravity: int
var velocity: Vector2 = Vector2()
var speed_upgrade = 0
var jump_upgrade = 0
var butthole_capacity = 0
var dead = false
var underwater = false
var key_taken = false
var paused = false
var jump_failed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = 'iddle'
#	$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
	
#	var speed = initial_speed + speed_upgrade

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	$Camera2D.position = $Camera2D.position.round()
	$Camera2D.force_update_scroll()
	if !dead and !paused:
		var jump = initial_jump + jump_upgrade * 60
		var speed = initial_speed + speed_upgrade * 15

	# Reset horizontal velocity
#		velocity.x = 0

	# Gravity
		velocity.y += gravity * delta

	# Controls
		if Input.is_action_pressed("a"):
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
		elif Input.is_action_pressed("d"):
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
		if Input.is_action_just_pressed("space") and is_on_floor():
			if Input.is_action_pressed("jumpboost"):
				velocity.y -= jump
			else:
				velocity.y -= initial_jump #* 60 * delta
		
#		if $AnimatedSprite.flip_h == false and is_on_floor():
#			if Input.is_action_pressed("d") == false:
#				velocity.x += initial_speed / 10
			
	# Apply the velocity
#		velocity.x = velocity.x * 70 * delta
		velocity = move_and_slide(velocity, Vector2.UP)
#		print("velocity.x = ", velocity.x)
		
	# Changing the Animation
		if !underwater:
			if velocity.x != 0:
				$AnimatedSprite.animation = 'running'
			elif velocity.x == 0:
				$AnimatedSprite.animation = 'iddle'
		if underwater:
			if velocity.x != 0:
				$AnimatedSprite.animation = 'running_underwater'
			elif velocity.x == 0:
				$AnimatedSprite.animation = 'iddle_underwater'
			
		if underwater == true:
			$UI/butthole_capacity/Panel/ProgressBar.value += 0.04
		
		if $UI/butthole_capacity/Panel/ProgressBar.value == 100:
			dead = true
			
		if dead == true:
			$UI/u_ded_lol.visible = true
			$UI/butthole_capacity.visible = false

func _on_Area2D_area_entered(area):
	get_parent().get_node("jump_carrot").queue_free()
	jump_upgrade += 1
	
func _on_water_area_area_entered(area):
	$UI/butthole_capacity.visible = true
	underwater = true
	jump_failed = true

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



func _on_challenge_area_exited(area):
	get_parent().get_node("help_panels/challenge/Panel1").visible = false
	get_parent().get_node("help_panels/challenge/Panel2").visible = false


func _on_jump_area_exited(area):
	if !jump_failed:
#		if self.position.y < -160:
		get_parent().get_node("help_panels/challenge").score += 1


func _on_finished_area_entered(area):
	if get_parent().get_node("help_panels/challenge").score == 5:
		get_parent().get_node("help_panels/challenge").finished = true
