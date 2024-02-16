extends Label

var obstacles_passed : int

func _ready():
	obstacles_passed = 0
	_update_text()

func _process(delta):
	_update_text()
	
func _update_text():
	text = "Obstacles Passed: %s" % [obstacles_passed]
	
func _obstacle_passed(obstacle):
	obstacles_passed += 1
