extends Area2D

@export var screenHeight = 480
@export var screenWidth = 640
@export var speed_multiplyer = 50

var speed = 0
var velocity = Vector2.ZERO 
var game_over = false;

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
			
	# Randomly calculate speed with following bounds:
	# speed = [10, speed_multiplyer + 10]
	speed = (randf() * speed_multiplyer) + 10
			
	$AnimatedSprite2D.play()

func _process(delta):
	if game_over:
		return
		
	# Move the Ghost based on the previously calculated
	# velocity vector.
	velocity = velocity.normalized() * speed
	position += velocity * delta
	
	# Wrap the Ghost around the X and Y bounds
	position.x = wrapf(position.x, 0, screenWidth)
	position.y = wrapf(position.y, 0, screenHeight)
	
func _on_score_label_s_game_over():
	# Signal handler that is connected to the s_game_over signal
	# when a Ghost is initialized by the main script.
	game_over = true
	$AnimatedSprite2D.stop()
