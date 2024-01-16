extends CharacterBody3D

@export var min_speed = 5
@export var max_speed = 15
@export var rotation_speed = 1

# Emit when player jumps on mob
signal caught

func catch():
	caught.emit()
	queue_free()

func _physics_process(delta):
	transform = transform.rotated_local(up_direction, rotation_speed * delta)
	move_and_slide()
	
func initialize(start_position, player_position):
	# Spawn the Mob in start_position and look towards player_position
	look_at_from_position(start_position, player_position, Vector3.UP)
	
	# Rotate the Mob randomly around Y-Axis
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	# Shoot the Mob away from the player at a random speed
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)

func _on_visible_on_screen_notifier_3d_screen_exited():
	# When the Mob exits the screen, the player failed
	# to catch it and it should be free'd
	queue_free()
