extends Node2D

var level: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	
# Exit
	if Input.is_action_pressed("escape"):
		get_tree().quit()
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()
