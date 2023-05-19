extends Node2D

func _process(delta):
	$loading.rotation_degrees += 1.5
	
	if  $loading.rotation_degrees >= 200:
		global.loaded = true
