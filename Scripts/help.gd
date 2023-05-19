extends Node2D

func _ready():
	pass # Replace with function body.

func _process(delta):
	if $Panel.visible == true:
		if Input.is_action_just_pressed("f"):
			$Panel.visible = false
			$Panel2.visible = true
