extends CharacterBody3D

var rotationAngleDegree : float
var rotationSpeedDegree : float
var rotationDirection : float

var motionVelocity : Vector3
var motionSpeedXZ : float
var motionDirectionXZ : int

var motionSpeedY : float
var motionDirectionY : int

func _ready():
	rotationAngleDegree = 0
	rotationSpeedDegree = 2
	rotationDirection = 0
	
	motionVelocity = Vector3.ZERO
	motionSpeedXZ = 500
	motionDirectionXZ = 0
	
	motionSpeedY = 100
	motionDirectionY = 0
	
func _process(delta):
	if Input.is_action_pressed("left_turn"):
		# Turn the flying craft counter-clockwise
		rotationDirection = 1.0
		
	if Input.is_action_pressed("right_turn"):
		# Turn the flying craft clockwise
		rotationDirection = -1.0
		
	if Input.is_action_pressed("forward"):
		# Move forward
		motionDirectionXZ = -1.0
		
	if Input.is_action_pressed("backwards"):
		# Move backwards
		motionDirectionXZ = 1.0
		
	if Input.is_action_pressed("up"):
		# Move up
		motionDirectionY = 1.0
		
	if Input.is_action_pressed("down"):
		# Move down
		motionDirectionY = -1.0
		
	Rotate(delta)
	Move(delta)

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
	motionDirectionXZ = 0
	motionDirectionY = 0
