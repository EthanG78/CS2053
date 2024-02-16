extends SpotLight3D

@export var Target : Node3D

func _ready():
	# Reset the spot light to the x and z origin while keeping it above ground
	position = Vector3(0, 5.0, 0)
	_look_at_target()

func _process(delta):
	_look_at_target()

func _look_at_target():
	look_at(Target.position, Vector3.UP)
