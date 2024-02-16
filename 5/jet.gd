extends CharacterBody3D

var circleRadius : float
var circleSpeed : float
var circleAngle : float #radians
var selfRotationSpeed : float
var lastDirection : Vector3

var collision : bool
var game_over : bool

func _ready():
	circleRadius = 10
	circleSpeed = 0.0
	circleAngle = 0
	selfRotationSpeed = 0.0
	
	collision = false

	lastDirection = Vector3(1, 0, 0)
	lastDirection.normalized()

	# Start the Jet off in the correct position along circle
	position = Vector3(circleRadius * cos(circleAngle), position.y, circleRadius * sin(circleAngle))
	
	_calculate_position(0.0)

func _physics_process(delta):
	if game_over:
		return
	
	selfRotationSpeed = 0
	circleSpeed = 0.0
	if Input.is_action_pressed("roll_left"):
		selfRotationSpeed = 1
	if Input.is_action_pressed("roll_right"):
		selfRotationSpeed = -1
	if Input.is_action_pressed("forward") and !collision:
		circleSpeed = .5
		
	_calculate_position(delta)
	transform = transform.rotated_local(Vector3.FORWARD, selfRotationSpeed * delta)

func _calculate_position(delta):
	circleAngle += circleSpeed * delta
	circleAngle = fmod(circleAngle , 2*PI)
	
	var newPositionX = circleRadius * cos(circleAngle)
	var newPositionZ = circleRadius * sin(circleAngle)

	var newPosition = Vector3(newPositionX, position.y, newPositionZ)
	var newDirection = (newPosition - position).normalized()
	
	var rotationAngle = -1*lastDirection.angle_to(newDirection)
	transform = transform.rotated(Vector3.UP, rotationAngle)

	position = newPosition
	lastDirection = newDirection
	
func _on_obstacle_collision():
	collision = true
	
func _on_obstacle_collision_end():
	collision = false
	
func _on_game_over():
	game_over = true
