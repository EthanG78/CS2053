extends Label

@export var GameTimer : Timer
@export var Dialog : AcceptDialog

signal s_game_over

func _ready():
	_update_text()

func _process(delta):
	_update_text()
	
func _update_text():
	text = "Time Remaining: %s s" % [int(GameTimer.time_left)]

func _on_game_timer_timeout():
	# Tell the Jet the game is over
	s_game_over.emit()
	# Diplay the PopupDialog with the "You Lose" Text
	Dialog.set_text("You Lose!")
	Dialog.set_visible(true)
