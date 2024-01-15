extends Label

@export var MAX_SCORE = 10
@export var winScreen : AcceptDialog

signal game_over

var score = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	text = "Score: %s\nGoal: %s" % [score, MAX_SCORE]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_mob_caught():
	score += 1
	text = "Score: %s\nGoal: %s" % [score, MAX_SCORE]
	
	if score == MAX_SCORE:
		game_over.emit()
		winScreen.visible = true

func _on_win_screen_confirmed():
	get_tree().reload_current_scene()
