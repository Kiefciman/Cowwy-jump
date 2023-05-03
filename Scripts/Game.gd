extends Node2D

var level: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	print("Loading assets")
	preload("res://Assets/UI/panel_background.png")
	preload("res://Assets/cow/diving_mask.png")
	preload("res://Assets/cow/idle/cow.png")
	preload("res://Assets/cow/idle/cow1.png")
	preload("res://Assets/cow/idle/cow2.png")
	preload("res://Assets/cow/idle/cow3.png")
	preload("res://Assets/cow/idle/cow4.png")
	preload("res://Assets/cow/idle/cow5.png")
	preload("res://Assets/cow/idle/cow6.png")
	preload("res://Assets/cow/idle/cow7.png")
	preload("res://Assets/cow/idle_underwater/cow.png")
	preload("res://Assets/cow/idle_underwater/cow2.png")
	preload("res://Assets/cow/idle_underwater/cow3.png")
	preload("res://Assets/cow/idle_underwater/cow4.png")
	preload("res://Assets/cow/idle_underwater/cow5.png")
	preload("res://Assets/cow/idle_underwater/cow6.png")
	preload("res://Assets/cow/idle_underwater/cow7.png")
	preload("res://Assets/cow/idle_underwater/cow1.png")
	preload("res://Assets/cow/running/cow1.png")
	preload("res://Assets/cow/running/cow2.png")
	preload("res://Assets/cow/running/cow3.png")
	preload("res://Assets/cow/running/cow4.png")
	preload("res://Assets/cow/running/cow5.png")
	preload("res://Assets/cow/running_underwater/cow1.png")
	preload("res://Assets/cow/running_underwater/cow2.png")
	preload("res://Assets/cow/running_underwater/cow3.png")
	preload("res://Assets/cow/running_underwater/cow4.png")
	preload("res://Assets/cow/running_underwater/cow5.png")
	preload("res://Assets/grass/grass-back/grass-back.png")
	preload("res://Assets/grass/grass-back/grass-back2.png")
	preload("res://Assets/grass/grass-back/grass-back3.png")
	preload("res://Assets/grass/grass-back/grass-back4.png")
	preload("res://Assets/grass/grass-front/grass-front1.png")
	preload("res://Assets/grass/grass-front/grass-front2.png")
	preload("res://Assets/grass/grass-front/grass-front3.png")
	preload("res://Assets/grass/grass-front/grass-front4.png")
	preload("res://Assets/ground/ground-mid.png")
	preload("res://Assets/ground/ground-small.png")
	preload("res://Assets/ground/ground-top.png")
	preload("res://Assets/items/Light.png")
	preload("res://Assets/items/carrot.png")
	preload("res://Assets/items/door-closed.png")
	preload("res://Assets/items/door-opened.png")
	preload("res://Assets/items/help_panel.png")
	preload("res://Assets/items/key.png")
	preload("res://Assets/trees/bush.png")
	preload("res://Assets/trees/leaf.png")
	preload("res://Assets/trees/crown1.png")
	preload("res://Assets/trees/crown2.png")
	preload("res://Assets/trees/tree1.png")
	preload("res://Assets/trees/tree2.png")
	preload("res://Assets/water/water.png")
	print("Loading shaders")
	preload("res://Shaders/background.shader")
	preload("res://Shaders/medium-wind.shader")
	preload("res://Shaders/medium2-wind.shader")
	preload("res://Shaders/slow-slow-wind.shader")
	preload("res://Shaders/slow-wind.shader")
	preload("res://Shaders/wind.shader")
	print("Done")
	print()
	
	$background.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	Engine.set_target_fps(Engine.get_iterations_per_second())
#	Engine.set_target_fps(75)
	
# Exit
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("f5"):
		if $background.material.get_shader_param("OCTAVE") == 10:
			$background.material.set_shader_param("OCTAVE", 3)
		elif $background.material.get_shader_param("OCTAVE") == 3:
			$background.material.set_shader_param("OCTAVE", 10)
			
