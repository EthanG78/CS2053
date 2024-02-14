extends CharacterBody3D

var circleRadius : float
var circleSpeed : float
var circleAngle : float #radians
var selfRotationSpeed : float
var lastDirection : Vector3

func _ready():
	circleRadius = 10
	circleSpeed = .5
	circleAngle = 0
	selfRotationSpeed = -0.5

	lastDirection = Vector3(1, 0, 0)
	lastDirection.normalized()

func _physics_process(delta):
	circleAngle += circleSpeed * delta

	circleAngle = fmod(circleAngle , 2*PI)
	
	var newPositionX = circleRadius * cos(circleAngle)
	var newPositionZ = circleRadius * sin(circleAngle)

	var newPosition = Vector3(newPositionX, position.y, newPositionZ)
	var newDirection = newPosition - position

	newDirection.normalized()

	var rotationAngle = -1*lastDirection.angle_to(newDirection)
	transform = transform.rotated(Vector3.UP, rotationAngle)
	transform = transform.rotated_local(Vector3.FORWARD, selfRotationSpeed * delta)

	position = newPosition
	lastDirection = newDirection
