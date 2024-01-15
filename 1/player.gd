extends CharacterBody3D

@export var speed = 14

@export var fall_acceleration = 75

var target_velocity = Vector3.ZERO

var game_over = false

func _handle_collisions():
	# iterate through all collisions that occured this frame
	for index in range(get_slide_collision_count()):
		# get one of the collisions with the player
		var collision = get_slide_collision(index)
		
		# collisions can be null?
		if collision.get_collider() == null:
			continue
			
		# collision is with an enemy
		if collision.get_collider().is_in_group("enemy"):
			var enemy = collision.get_collider()
			enemy.catch()
			break

func _physics_process(delta):
	if game_over:
		return
	
	var direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	if Input.is_action_pressed("move_back"):
		direction.z += 1
	if Input.is_action_pressed("move_forward"):
		direction.z -= 1
	
	# Make sure we don't move faster diagonally
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		$Pivot.look_at(position + direction, Vector3.UP)
		
	# ground velocity
	target_velocity.x = direction.x * speed
	target_velocity.z = direction.z * speed

	# vertical velocity
	if not is_on_floor():
		target_velocity.y = target_velocity.y - (fall_acceleration * delta)
		
	velocity = target_velocity
	
	_handle_collisions()
	move_and_slide()


func _on_score_label_game_over():
	game_over = true
