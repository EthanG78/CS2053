extends Label

@export var GameOverDialog : AcceptDialog

signal s_game_over

var score = 0.0
var game_over = false

func _update_label():
	# Round score to 1 decimal places
	score = snapped(score, 0.01)
	text = "Objective: Survive\nScore: %s" % [score]

func _ready():
	# Initialize the score as zero.
	score = 0
	_update_label()

func _process(delta):
	if game_over:
		return
		
	# Update the score to be the time 
	# that has passed since the last frame.
	score += delta
	_update_label()

func _on_player_area_entered(area):
	# The player has collided with another Area2D, we must
	# check to make sure that it isn't the background.
	if area.name != "Background":
		# Game over state
		s_game_over.emit()
		game_over = true
		GameOverDialog.set_text("Score: %s seconds" % [score])
		GameOverDialog.set_visible(true)

