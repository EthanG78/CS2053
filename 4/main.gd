extends Node

@export var PopupDialog : AcceptDialog
@export var ObstacleTemplate : PackedScene

signal obstacles_changed

func _ready():
	var groundSize = $Ground/MeshInstance3D.mesh.size
	
	# Create between 3 and 7 obstacles and place them randomly
	var nObstacles = int(randf() * 4 + 3)
	for i in range(0, nObstacles):
		var obstacle = ObstacleTemplate.instantiate()
	
		# Calculate where to spawn the Obstacle
		var obstacleX = (randf() * groundSize.x) - groundSize.x/2
		var obstacleZ = (randf() * groundSize.z) - groundSize.z/2
		var obstaclePos = Vector3(obstacleX, 30.0, obstacleZ)
		
		# Initialize the new object in the world
		obstacle.Initialize(obstaclePos)
		
		# Add the obstacle to the scene
		add_child(obstacle)
		
	# Let the UI know how many obstacles we have
	obstacles_changed.emit(nObstacles)

func _process(delta):
	if Input.is_action_just_released("restart"):
		get_tree().reload_current_scene()

func _on_flying_craft_crash():
	PopupDialog.set_title("Game Over")
	PopupDialog.set_text("Restart Game?")
	PopupDialog.set_visible(true)

func _on_popup_dialog_confirmed():
	get_tree().reload_current_scene()
