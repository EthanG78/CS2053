extends CharacterBody3D

@export var min_speed = 10
@export var max_speed = 18
@export var rotation_speed = 1

# emit when player jumps on mob
signal caught

func catch():
	caught.emit()
	queue_free()

func _physics_process(delta):
	transform = transform.rotated_local(up_direction, rotation_speed * delta)
	move_and_slide()
	
func initialize(start_position, player_position):
	look_at_from_position(start_position, player_position, Vector3.UP)
	rotate_y(randf_range(-PI / 4, PI / 4))
	
	var random_speed = randi_range(min_speed, max_speed)
	velocity = Vector3.FORWARD * random_speed
	velocity = velocity.rotated(Vector3.UP, rotation.y)


func _on_visible_on_screen_notifier_3d_screen_exited():
	queue_free()
