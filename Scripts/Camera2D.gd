extends Camera2D

export (NodePath) var TargetNodePath
export (float) var lerp_speed = 0.1
onready var targetNode = get_node(TargetNodePath)
var pos_x : int
var pos_y : int

func _ready():
	set_as_toplevel(true)
	
func _physics_process(delta):
	var smooth_stabilizer = 1 - pow(lerp_speed, delta)
	pos_x = int(lerp(self.global_position.x, targetNode.global_position.x, smooth_stabilizer))
	pos_y = int(lerp(self.global_position.y, targetNode.global_position.y, smooth_stabilizer))
	self.global_position = Vector2(pos_x, pos_y)
