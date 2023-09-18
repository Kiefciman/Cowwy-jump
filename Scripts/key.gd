extends Node2D

func _ready():
	pass
	
func _on_key_body_entered(body):
	if body.is_in_group("player"):
		body.key_taken = true
		self.queue_free()
