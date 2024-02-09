extends Node3D

func Initialize(pos):
	# Assign position
	position = pos
	
	# Randomly rotate obstacle about Y axis
	rotate_y(randf_range(-PI / 4, PI / 4))

func _on_trigger_body_exited(body):
	# When the ship passes through the obstacle, 
	# we delete it from the scene.
	if body.name == "FlyingCraft":
		queue_free()
