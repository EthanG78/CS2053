extends Node

@export var GameTimer : Timer
@export var Dialog : AcceptDialog

var ambient_light : bool
var directional_light : bool
var point_light : bool
var spot_light : bool

var round_timers = [30, 25, 20, 15]
var round_timer_idx = 0

signal s_game_over

func _ready():
	ambient_light = true
	directional_light = true
	point_light = true
	spot_light = true
	_update_timer()

func _process(delta):
	if Input.is_action_just_released("ambient_light_toggle"):
		$Jet/Camera3D.environment.ambient_light_color = Color.BLACK if !ambient_light else Color.RED
		ambient_light = !ambient_light
	if Input.is_action_just_released("directional_light_toggle"):
		if directional_light:
			_turn_node_off($DirectionalLight)
		else:
			_turn_node_on($DirectionalLight)
		directional_light = !directional_light
	if Input.is_action_just_released("point_light_toggle"):
		if point_light:
			_turn_node_off($OmniLight)
		else:
			_turn_node_on($OmniLight)
		point_light = !point_light
	if Input.is_action_just_released("spot_light_toggle"):
		if spot_light:
			_turn_node_off($SpotLight)
		else:
			_turn_node_on($SpotLight)
		spot_light = !spot_light

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

func _turn_node_off(node : Node):
	node.process_mode = 4
	node.hide()

func _turn_node_on(node : Node):
	node.process_mode = 0
	node.show()
