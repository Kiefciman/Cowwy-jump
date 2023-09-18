extends Sprite

func _ready():
	pass # Replace with function body.


func _on_water_area_body_entered(body):
	if body.is_in_group("player"):
		body.get_node("UI/butthole_capacity").visible = true
		body.underwater = true
		body.left_entered = false
		body.left_exited = false
		body.right_entered = false
		body.right_exited = false


func _on_water_area_body_exited(body):
	if body.is_in_group("player"):
		body.get_node("UI/butthole_capacity").visible = false
		body.underwater = false
