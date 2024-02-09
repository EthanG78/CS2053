extends Label

const labelText : String = "Obstacles Remaining:"

func _ready():
	text = labelText

func _on_main_obstacles_changed(nObstacles):
	text = "%s %s" % [labelText, nObstacles]
