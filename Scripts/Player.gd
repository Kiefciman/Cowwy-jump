extends KinematicBody2D

# Variables
export var speed: int
export var jump: int
export var gravity: int
var velocity: Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.animation = 'iddle'

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

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
	if velocity.x != 0:
		$AnimatedSprite.animation = 'running'
	elif velocity.x == 0:
		$AnimatedSprite.animation = 'iddle'
