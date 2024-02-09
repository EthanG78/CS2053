extends CharacterBody3D

var rotationAngleDegree : float
var rotationSpeedDegree : float
var rotationDirection : float

var motionVelocity : Vector3
var motionSpeedXZ : float
var motionDirectionXZ : int

var motionSpeedY : float
var motionDirectionY : int

var gameOver : bool

signal crash

func _ready():
	rotationAngleDegree = 0
	rotationSpeedDegree = 2
	rotationDirection = 0
	
	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 500.0
	motionDirectionXZ = -1
	
	motionSpeedY = 100
	motionDirectionY = 0
	
func _process(delta):
	if gameOver:
		return
	
	if Input.is_action_pressed("left_turn"):
		# Turn the flying craft counter-clockwise
		rotationDirection = 1
		
	if Input.is_action_pressed("right_turn"):
		# Turn the flying craft clockwise
		rotationDirection = -1
		
	if Input.is_action_pressed("up"):
		# Move up
		motionDirectionY = 1
		
	if Input.is_action_pressed("down"):
		# Move down
		motionDirectionY = -1
		
	Rotate(delta)
	Move(delta)
	
func _physics_process(delta):
	if gameOver:
		return
	# If I want to handle collisions using 
	# get_slide_collision_count(), I need 
	# to move_and_slide()
	Handle_Collisions()
	move_and_slide()

func Rotate(delta):
	var rotationVelocityDegree = rotationSpeedDegree * rotationDirection
	
	rotationAngleDegree += rotationVelocityDegree * delta
	
	# Make sure that rotationAngleDegree within 0-2pi
	var rotationAngleRadian = float(rotationAngleDegree / 360.0) * (PI * 2.0)
	if rotationAngleRadian > 2 * PI:
		rotationAngleRadian = rotationAngleRadian - (2 * PI)
		
	transform = transform.rotated_local(Vector3.UP, rotationVelocityDegree * delta)

func Move(delta):
	# Convert degree to radian
	var rotationAngleRadian = float(rotationAngleDegree / 360.0) * (PI * 2.0)
	var motionX = sin(rotationAngleRadian) * motionDirectionXZ
	var motionZ = cos(rotationAngleRadian) * motionDirectionXZ
	var motionY = motionDirectionY
	
	motionVelocity = Vector3(motionX, motionY, motionZ)
	
	# Normalized vector to represent the directions of motionVelocity
	motionVelocity.normalized()
	
	motionVelocity = Vector3(motionVelocity.x * motionSpeedXZ, motionVelocity.y * motionSpeedY, motionVelocity.z * motionSpeedXZ)
	transform = transform.translated_local(motionVelocity * delta)
	
	rotationDirection = 0
	motionDirectionXZ = -1
	motionDirectionY = 0
	
func Handle_Collisions():
	# Iterate through all collisions that occured this frame
	for index in range(get_slide_collision_count()):
		# Get one of the collisions with the ship
		var collision = get_slide_collision(index)
		
		# Collisions can be null?
		if collision.get_collider() == null:
			continue
			
		# Collision with ground or obtacle
		if collision.get_collider().is_in_group("ground") or collision.get_collider().is_in_group("obstacle"):
			# Results in Game Over
			crash.emit()
			gameOver = true
			break;

func _on_main_game_won():
	gameOver = true
