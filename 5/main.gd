extends Node

@export var GameTimer : Timer
@export var Dialog : AcceptDialog

var round_timers = [30, 25, 20, 15]
var round_timer_idx = 0

signal s_game_over

func _ready():
	_update_timer()

func _process(delta):
	pass

func _on_popup_dialog_confirmed():
	get_tree().reload_current_scene()

func _on_obstacle_4_s_passed(node_name):
	# When we pass obstacle 4, we want the timer to reset
	# with a harder time. If the player has played all the rounds, then 
	# tell them they have won.
	round_timer_idx = round_timer_idx + 1
	if round_timer_idx >= round_timers.size():
		GameTimer.stop()
		# Tell the Jet the game is over
		s_game_over.emit()
		# Diplay the PopupDialog with the "You Win" Text
		Dialog.set_text("You Win!")
		Dialog.set_visible(true)
	else:
		_update_timer()
		
func _update_timer():
	GameTimer.wait_time = round_timers[round_timer_idx]
	GameTimer.start()
