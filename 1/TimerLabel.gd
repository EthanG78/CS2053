extends Label

@export var GameTimer : Timer
@export var LoseScreen : AcceptDialog

signal game_over

func _ready():
	text = "Time Remaining: %s s" % [int(GameTimer.time_left)]

func _process(delta):
	# Update the label with the time remaining in the game timer
	text = "Time Remaining: %s s" % [int(GameTimer.time_left)]

func _on_game_timer_timeout():
	# Tell the Player the game is over
	game_over.emit()
	# Diplay the PopupDialog with the "You Lose" Text
	LoseScreen.set_text("You Lose!")
	LoseScreen.set_visible(true)
