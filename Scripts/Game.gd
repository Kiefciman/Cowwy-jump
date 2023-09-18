extends Node2D

var level: int = 1
var wind_directions = [-1, 1]
var wind_speed_old
var t = 0
var tplus = true
var change_speed_plus_minus = 1
var s = 0
var starget: int
var speedplus: float
export var fly_scene: PackedScene
export var rock_scene: PackedScene
export var fish_scene: PackedScene
export var crow_scene: PackedScene

func spawn_flies(amount):
	for i in range(amount):
		var fly = fly_scene.instance()
		$animals/flies.add_child(fly)
		fly.position = Vector2(int(rand_range(10.0, 1670.0)), int(rand_range(-20.0, -530.0)))
		
func spawn_rocks(amount, x_min, x_max, y_min, y_max):
	for i in range(randi() % amount + 1):
		var rock = rock_scene.instance()
		$rocks.add_child(rock)
		rock.position = Vector2(int(rand_range(x_min, x_max)), int(rand_range(y_min, y_max)))
		
func spawn_crows(amount, x_min, x_max, y_min, y_max):
	for i in range(randi() % amount + 1):
		var crow = crow_scene.instance()
		$animals/crows.add_child(crow)
		crow.position = Vector2(int(rand_range(x_min, x_max)), int(rand_range(y_min, y_max)))

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$background/background.visible = true
	global.wind_direction = wind_directions[randi() % 2]
	global.wind_speed = rand_range(0.03, 0.3) * global.wind_direction
	spawn_flies(200)
	spawn_rocks(4, 10, 180, -20, -30)
	spawn_rocks(3, 410, 720, -85, -95)
	spawn_rocks(6, 1350, 1660, -210, -220)
	spawn_rocks(3, 870, 1280, -370, -380)
	spawn_rocks(2, 220, 630, -405, -415)
	for water in $ground/Water/surface.get_children():
		var fish = fish_scene.instance()
		fish.global_position = water.global_position + Vector2(10, 10)
		self.add_child(fish)
#	for water in $ground/Water/underground.get_children():
#		var fish = fish_scene.instance()
#		water.add_child(fish)
	spawn_crows(4, 1300, 1620, -240, -340)

func _process(delta):
	Engine.set_target_fps(Engine.get_iterations_per_second())
	$cursor.position = get_global_mouse_position()
	$cursor.rotation_degrees += 0.5 * delta * 100
	#$cam.position = $Player.position
	#Engine.set_target_fps(75)
	
	if $animals/flies.get_child_count() == 50:
		spawn_flies(150)

#	if change_speed_plus_minus == 1:
#		global.wind_speed += 0.01
#	elif change_speed_plus_minus == -1:
#		global.wind_speed -= 0.01
#	$background.material.set_shader_param("speed", global.wind_direction)
#	print(change_speed_plus_minus)
#	print(global.wind_speed)
	
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("f5"):
		if $background/background.material.get_shader_param("OCTAVE") == 10:
			$background/background.material.set_shader_param("OCTAVE", 3)
		elif $background/background.material.get_shader_param("OCTAVE") == 3:
			$background/background.material.set_shader_param("OCTAVE", 10)
	if Input.is_action_just_released("debug"):
		change_speed_plus_minus *= -1
			
