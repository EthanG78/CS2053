extends Node2D

@export var GhostTemplate : PackedScene

var game_over = false

func _on_ghost_timer_timeout():
	if game_over:
		return
	
	# Create a new Ghost
	var ghost = GhostTemplate.instantiate()
	
	# Attach the ScoreLabel's s_game_over 
	# signal to the spawned Ghost.
	$UserInterface/ScoreLabel.s_game_over.connect(ghost._on_score_label_s_game_over)
	
	# Add the Ghost to the scene
	add_child(ghost)

func _on_game_over_confirmed():
	get_tree().reload_current_scene()

func _on_score_label_s_game_over():
	game_over = true
