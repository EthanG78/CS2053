extends Label

@export var MAX_SCORE = 10
@export var WinScreen : AcceptDialog

signal game_won

var score = 0

func _ready():
	text = "Score: %s\nGoal: %s" % [score, MAX_SCORE]

func _on_mob_caught():
	score += 1
	text = "Score: %s\nGoal: %s" % [score, MAX_SCORE]
	
	if score == MAX_SCORE:
		# Tell the Player the game is won
		game_won.emit()
		# Diplay the PopupDialog with the "You Win" Text
		WinScreen.set_text("You Win!")
		WinScreen.set_visible(true)

func _on_win_screen_confirmed():
	get_tree().reload_current_scene()
