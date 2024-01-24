extends Node2D

@export var GhostTemplate : PackedScene

func _on_ghost_timer_timeout():
	# Create a new Ghost
	var ghost = GhostTemplate.instantiate()
	
	# Add the Ghost to the scene
	add_child(ghost)
