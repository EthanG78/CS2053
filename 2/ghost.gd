extends Area2D

@export var screenHeight = 480
@export var screenWidth = 640
@export var speed = 25

var velocity = Vector2.ZERO 

# Called when the node enters the scene tree for the first time.
func _ready():
	# Generate two random numbers: SpawnLocation1 and
	# SpawnLocation2. SpawnLocation1 decides if the Ghost
	# spawns on the X or Y border, and SpawnLocation2
	# decides what direction the ghost will move.
	var spawnLocation1 = randf()
	var spawnLocation2 = randf()
	if spawnLocation1 > 0.5:
		position.y = randf() * screenHeight
		if spawnLocation2 > 0.5:
			position.x = screenWidth
			velocity.x -= 1
			$AnimatedSprite2D.animation = "Left"
		else:
			position.x = 0
			velocity.x += 1
			$AnimatedSprite2D.animation = "Right"
	else:
		position.x = randf() * screenWidth
		if spawnLocation2 > 0.5:
			position.y = screenHeight
			velocity.y -= 1
			$AnimatedSprite2D.animation = "Up"
		else:
			position.y = 0
			velocity.y += 1
			$AnimatedSprite2D.animation = "Down"
			
	$AnimatedSprite2D.play()

func _process(delta):
	# Move the Ghost based on the previously calculated
	# velocity vector.
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	# Wrap the Ghost around the X and Y bounds
	position.x = wrapf(position.x, 0, screenWidth)
	position.y = wrapf(position.y, 0, screenHeight)
