extends CharacterBody2D

@export var PlayerCamera : Camera2D

const SPEED = 150.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var prev_direction = "Right"

func _process(delta):
	# Have the camera follow the player
	PlayerCamera.position.x = position.x

func _physics_process(delta):
	var on_floor = is_on_floor()
	
	# Add the gravity.
	if not on_floor:
		$AnimatedSprite2D.animation = "Jump"
		velocity.y += gravity * delta	

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Handle horizontal movement.
	var direction = 0
	if Input.is_action_pressed("left"):
		direction += -1
		prev_direction = "Left"
		if on_floor:
			$AnimatedSprite2D.animation = "Left"
	elif Input.is_action_pressed("right"):
		direction += 1
		prev_direction = "Right"
		if on_floor:
			$AnimatedSprite2D.animation = "Right"
	elif on_floor:
		# Idle animation based on last direction the Player was facing
		$AnimatedSprite2D.animation =  "Standing" + prev_direction
			
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	$AnimatedSprite2D.play()
	move_and_slide()
