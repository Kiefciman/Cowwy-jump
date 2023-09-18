extends RigidBody2D

export var jump: int = 100
export var speed: int = 50
#export var gravity: int = 800
#export var mass:int = 20
#var velocity: Vector2 = Vector2()
var t = 0
var t_mod: int
var t_plus_min: int
var index = [-1, 1]
var jump_mod: int
var speed_mod: int
var direction: int
var jump_plus_minus: int
var speed_plus_minus: int
export var idle: Resource
export var jumping: Resource
export var mouth_open: Resource
export var blushing: Resource
var landed = false
var initial_position: Vector2
var s = 0
var states = ['idle', 'slap', 'eat']
var self_state
var hunger = 0
onready var cow = get_node("/root/Level/Player")
onready var cow_face = get_node("/root/Level/Player/face")
onready var cow_ui = get_node("/root/Level/Player/UI/butthole_capacity")
var slapping = 0
var desire_to_slap = -1
#var flies = get_node("/root/Level/animals/flies").get_children()
#var flies = get_tree().get_nodes_in_group("flies")
var z = 0
var b = 0
#var infinite_inertia = false
#var velocity = self.linear_velocity

func slap(target):
	self_state = states[1]	
	$Tongue.visible = true
	$Sprite.texture = mouth_open
	if target.global_position.x < $Tongue.global_position.x:
		$Tongue.scale.x = $Tongue.global_position.distance_to(target.global_position)
		$Tongue.rotation_degrees = (target.global_position.y - $Tongue.global_position.y) * -1
	else:
		$Tongue.scale.x = -$Tongue.global_position.distance_to(target.global_position)
		$Tongue.rotation_degrees = target.global_position.y - $Tongue.global_position.y
	slapping += 1

func end_slap():
#	b += 1
	self_state = states[0]
	$Sprite.texture = blushing
	$Tongue.visible = false
	$Tongue.scale.x = 0
	$Tongue.rotation_degrees = 0
	slapping = 0
	desire_to_slap = -1
#	if b > 100:
#		$Sprite.texture = idle
#		b = 0
	
func eat(target):
	self_state = states[2]
	$Tongue.visible = true
	$Sprite.texture = mouth_open
	if target.global_position.x < $Tongue.global_position.x:
		$Tongue.scale.x = $Tongue.global_position.distance_to(target.global_position)
		$Tongue.rotation_degrees = (target.global_position.y - $Tongue.global_position.y) * -1
	else:
		$Tongue.scale.x = -$Tongue.global_position.distance_to(target.global_position)
		$Tongue.rotation_degrees = target.global_position.y - $Tongue.global_position.y
	target.velocity = Vector2(0, 0)
	z += 1
	if z > 20:
		$Sprite.texture = idle
		self_state = states[0]
		target.queue_free()
		$Tongue.visible = false
		$Tongue.scale.x = 0
		$Tongue.rotation_degrees = 0
		hunger = 0
		z = 0
		
#func minus_gravity(a):
#	velocity.y -= a

func _ready():
	t_mod = randi() % 100 + 1
	t_plus_min = index[randi() % 2]
	$Sprite.texture = idle
	$Tongue.visible = false
#	self.contact_monitor = true
#	self.contacts_reported = 1
	initial_position = self.global_position
	self_state = states[0]
#
#func _physics_process(delta):
#	velocity.y += gravity * delta
func _integrate_forces(state):
	hunger += 1
	s += 1
#	velocity.x = 0
	if self_state == states[0]:
		t += 1
#		print(t)
		if landed:# is_on_floor():
			if t >= 200 + t_plus_min * t_mod:
		#		$Sprite.texture = jumping
				speed_plus_minus = index[randi() % 2]
				jump_plus_minus = index[randi() % 2]
				speed_mod = randi() % 11 * speed_plus_minus
				jump_mod = randi() % 51 * jump_plus_minus
				if self.global_position.x > 40:
					direction = randi() % 3 - 1
				else:
					direction = 1
				if direction != 0:
					self.linear_velocity.y = -jump + jump_mod
					self.linear_velocity.x = speed * direction + speed_mod
					$AudioStreamPlayer2D.play()
#					apply_central_impulse(Vector2(speed, -jump))
#					print(self.linear_velocity.x)
#					print("A")
				t_mod = randi() % 100 + 1
				t_plus_min = index[randi() % 2]
	#			if landed:#is_on_floor():
				t = 0
				desire_to_slap = index[randi() % 2]
#			else:
#				self.linear_velocity.x = 0
		
#		if s > 5000:
#			self.global_position.y -= 50
#			s = 0
			
#	if is_on_floor():
#		velocity.x *= 0.8
			
	if $Sprite.texture == idle:
		$Tongue.scale.x = 0
		$Tongue.visible = false

	if desire_to_slap == 1 and landed:#is_on_floor():
		if self.global_position.distance_to(cow.global_position) < 40:
			slap(cow_face)
			if cow.butthole_capacity > 0 and not cow.underwater:
				cow.butthole_capacity -= 1
				cow_ui.visible = true
		else:
			end_slap()
			if not cow.underwater:
				cow_ui.visible = false
		
	if slapping > 50:
		end_slap()
		
	var flies = get_node("/root/Level/animals/flies").get_children()
	for fly in flies:
		if self.global_position.distance_to(fly.global_position) < 40 and hunger > 200 and self.linear_velocity == Vector2(0, 0):
			eat(fly)

	self.angular_velocity = 0
	self.rotation_degrees = 0
#	if landed:
#		print(landed)
#	print(mass)
	
#	velocity = move_and_slide(velocity, Vector2.UP, false, 1, PI/4, infinite_inertia)
#	move_and_collide(velocity, infinite_inertia)

	if sleeping:
		print("aaaaaaaaa")
#	print(sleeping)
	
func _on_Frog_body_entered(body):
	$Sprite.texture = idle
	landed = true

func _on_Frog_body_exited(body):
	$Sprite.texture = jumping
	landed = false
	s = 0


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.stop()
