extends Node

@export var PopupDialog : AcceptDialog
@export var ObstacleTemplate : PackedScene

var NObstacles : int

signal obstacles_changed(n_obstacles)
signal game_won

func _ready():
	var groundSize = $Ground/MeshInstance3D.mesh.size
	
	# Create between 3 and 7 obstacles and place them randomly
	NObstacles = int(randf_range(3, 10))
	for i in range(0, NObstacles):
		var obstacle = ObstacleTemplate.instantiate()
	
		# Calculate where to spawn the Obstacle
		var obstacleX = (randf() * groundSize.x) - groundSize.x/2
		var obstacleZ = (randf() * groundSize.z) - groundSize.z/2
		var obstaclePos = Vector3(obstacleX, 30.0, obstacleZ)
		
		# Initialize the new object in the world
		obstacle.Initialize(obstaclePos)
		
		# Connect to the signals emitted from trigger in obstacles
		obstacle.get_node("Trigger").body_exited.connect(_on_obstacle_cleared)

		
		# Add the obstacle to the scene
		add_child(obstacle)
		
	# Let the UI know how many obstacles we have
	obstacles_changed.emit(NObstacles)

func _process(delta):
	if Input.is_action_just_released("restart"):
		get_tree().reload_current_scene()

func _on_flying_craft_crash():
	PopupDialog.set_title("Game Over")
	PopupDialog.set_text("You Lose!")
	PopupDialog.set_visible(true)
	
func _on_obstacle_cleared(body):
	if body.name == "FlyingCraft":
		NObstacles = NObstacles - 1
		obstacles_changed.emit(NObstacles)
		if NObstacles == 0:
			game_won.emit()
			PopupDialog.set_title("Game Over")
			PopupDialog.set_text("You Win!")
			PopupDialog.set_visible(true)

func _on_popup_dialog_confirmed():
	get_tree().reload_current_scene()
	
