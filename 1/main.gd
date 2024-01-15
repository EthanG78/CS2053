extends Node

@export var EnemyTemplate : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_spawn_timer_timeout():
	var enemy = EnemyTemplate.instantiate()
	var groundSize = $Ground/MeshInstance3D.mesh.size
	enemy.position.x = (randf() * groundSize.x) - groundSize.x/2
	enemy.position.z = (randf() * groundSize.z) - groundSize.z/2
	enemy.caught.connect($UserInterface/ScoreLabel._on_mob_caught)
	add_child(enemy)
