extends Node3D

signal s_collision
signal s_end_collision
signal s_passed(node_name)

func _on_pillar_body_entered(body):
	if body.name == "Jet":
		# The jet has collided with the obstacle
		s_collision.emit()
		
func _on_pillar_body_exited(body):
	if body.name == "Jet":
		# The jet has left the collision with the obstacle
		s_end_collision.emit()

func _on_trigger_body_exited(body):
	if body.name == "Jet":
		# The jet has passed through the obstacle
		s_passed.emit(name)
