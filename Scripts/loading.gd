extends Node2D

onready var level = "res://Scenes/Node2D.tscn"
onready var loading = ("res://Scenes/Loading.tscn")

func _ready():
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
	preload("res://Assets/background/grass-back.png")
	preload("res://Assets/background/grass.png")
	preload("res://Assets/background/ground-mid-old.png")
	preload("res://Assets/background/ground-mid.png")
	preload("res://Assets/UI/loading.png")
	preload("res://Assets/background/grass-down.png")
	preload("res://Assets/background/ground-top.png")
	preload("res://Assets/background/ground-bot.png")
	preload("res://Assets/UI/cursor.png")
	preload("res://Assets/items/apple.png")
	preload("res://Assets/animals/frog.png")
	print("Loading shaders")
	preload("res://Shaders/background.shader")
	preload("res://Shaders/medium-wind.shader")
	preload("res://Shaders/medium2-wind.shader")
	preload("res://Shaders/slow-slow-wind.shader")
	preload("res://Shaders/slow-wind.shader")
	preload("res://Shaders/wind.shader")
	print("Done")
	print()
	
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta):
	$cursor.position = get_global_mouse_position()
	$cursor.rotation_degrees += 0.5 * delta * 100
	$loading.rotation_degrees += 1.5 * delta * 100
	if $loading.rotation_degrees >= 500:
		get_tree().change_scene(level)