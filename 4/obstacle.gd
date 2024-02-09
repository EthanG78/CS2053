extends Node3D

func Initialize(pos):
	# Assign position
	position = pos
	
	# Randomly rotate obstacle about Y axis
	rotate_y(randf_range(-PI / 4, PI / 4))
