extends Node2D

var challenge

func _ready():
	self.visible = false
	challenge = false
	$Panel1.visible = false
	$Panel2.visible = false
	
func _process(delta):
#	print($Panel1.visible)
	if challenge == true:
		self.visible = true
