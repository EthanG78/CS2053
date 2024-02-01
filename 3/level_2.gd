extends Node2D

func _on_restart_trigger_body_exited(body):
	# Restart if the player falls past the restart trigger
	# Adding check to see if get_tree() is null or not as it
	# seems this gets fired on scene transition...	
	if body.name == "Player" and get_tree():
		get_tree().reload_current_scene()

func _on_transition_trigger_body_entered(body):
	# Transition to next stage if the Player enters trigger
	if body.name == "Player":
		get_tree().change_scene_to_file("res://main.tscn")
