extends StaticBody2D

var active = false

func _ready():
	self.modulate = Color(1.0, 1.0, 1.0, 0.6)

func _process(delta):
	if active == false:
		self.modulate = Color(1.0, 1.0, 1.0, 0.6)
		$CollisionShape2D.disabled = true
	elif active == true: 
		self.modulate = Color(1.0, 1.0, 1.0, 1.0)
		$CollisionShape2D.disabled = false
