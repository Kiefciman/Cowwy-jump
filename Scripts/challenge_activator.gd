extends Node2D
onready var player = get_parent().get_parent().get_node("Player")

func _ready():
	pass # Replace with function body.

func _process(delta):
	if $Panel.visible == true:
		if Input.is_action_just_pressed("f"):
			$Panel.visible = false
			$Panel2.visible = true
	
	var apples_eaten = player.apples_eaten
	$Panel2/RichTextLabel.text = " U need to eat " + str(15 - apples_eaten) + """ more
 apples to unlock this"""
	
