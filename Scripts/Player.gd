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

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = 'iddle'
#	$UI/butthole_capacity/Panel/ProgressBar.value = butthole_capacity
	
#	var speed = initial_speed + speed_upgrade

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !dead:
		var speed = initial_speed + speed_upgrade * 20
		var jump = initial_jump + jump_upgrade * 100

	# Reset horizontal velocity
		velocity.x = 0

	# Gravity
		velocity.y += gravity * delta

	# Controls
		if Input.is_action_pressed("a"):
			velocity.x -= speed
			$AnimatedSprite.flip_h = true
		if Input.is_action_pressed("d"):
			velocity.x += speed
			$AnimatedSprite.flip_h = false
		if Input.is_action_just_pressed("space") and is_on_floor():
			velocity.y -= jump
			
	# Apply the velocity
		velocity = move_and_slide(velocity, Vector2.UP)
		
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


func _on_water_area_area_exited(area):
	$UI/butthole_capacity.visible = false
	underwater = false


func _on_speed_carrot_area_entered(area):
	get_parent().get_node("speed_carrot").queue_free()
	speed_upgrade += 1
