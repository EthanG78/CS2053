extends Area2D

# hmmmm is this the best way to get screen size?
@export var screenHeight = 480
@export var screenWidth = 640
@export var speed = 100

var game_over = false

func _process(delta):
	if game_over:
		return
	
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		$AnimatedSprite2D.animation = "Right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		$AnimatedSprite2D.animation = "Left"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		$AnimatedSprite2D.animation = "Down"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		$AnimatedSprite2D.animation = "Up"
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
		
	position += velocity * delta
	
	# Wrap the player around the X and Y bounds
	position.x = wrapf(position.x, 0, screenWidth)
	position.y = wrapf(position.y, 0, screenHeight)


func _on_score_label_s_game_over():
	$AnimatedSprite2D.stop()
	game_over = true;
