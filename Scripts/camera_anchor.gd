extends Position2D

onready var player = get_parent().get_node("Player")
export var lerp_ammount = 0.2

func _process(delta):
	var target = player.global_position
	var target_position_x
	var target_position_y
	target_position_x = int(lerp(global_position.x, target.x, lerp_ammount))
	target_position_y = int(lerp(global_position.y, target.y, lerp_ammount))
	global_position = Vector2(target_position_x, target_position_y)
