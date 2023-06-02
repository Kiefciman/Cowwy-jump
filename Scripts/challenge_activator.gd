extends Node2D

var challenge_accepted
onready var player_camera = $"../../Player".get_node("Camera2D")
onready var player = $"../../Player"
onready var camera = $"../../Camera1"
onready var camera_timer = $"../../Camera1/Timer"
onready var camera_timer2 = $"../../Camera1/Timer2"
onready var challenge = $"../challenge"

func _ready():
	challenge_accepted = false
	
func _process(delta):
	if $Panel.visible == true:
		if challenge_accepted == false:
			if Input.is_action_pressed("f"):
				challenge.score = 0
				$Panel.visible = false
				$Panel2.visible = true
				challenge.challenge = true
				challenge_accepted = true
				player_camera.current = false
				player.paused = true
				camera.current = true
				camera_timer.start()
				camera_timer.paused = false
				camera.zoom = Vector2(1, 1)
		elif challenge_accepted == true:
			if Input.is_action_pressed("f"):
				$Panel.visible = false
				$Panel2.visible = true


func _on_Timer_timeout():
	camera_timer2.start()
	camera_timer2.paused = false
	camera.zoom = Vector2(0.5, 0.5)

func _on_Timer2_timeout():
	camera.current = false
	player_camera.current = true
	player.paused = false
