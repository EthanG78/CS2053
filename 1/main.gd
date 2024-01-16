extends Node

@export var EnemyTemplate : PackedScene

func _on_spawn_timer_timeout():
	# Create a new Mob
	var mob = EnemyTemplate.instantiate()
	
	# Calculate where to spawn the Mob
	var groundSize = $Ground/MeshInstance3D.mesh.size
	var mobX = (randf() * groundSize.x) - groundSize.x/2
	var mobZ = (randf() * groundSize.z) - groundSize.z/2
	var mobPos = Vector3(mobX, 1.0, mobZ)
	
	# Initialize the Mob position and tell them where the player is
	mob.initialize(mobPos, $Player.position)
	
	# Connect the Mob's caught signal
	mob.caught.connect($UserInterface/ScoreLabel._on_mob_caught)
	
	# Add the enemy to the scene
	add_child(mob)

func _on_game_done():
	# When we get the signal that the game is won or over,
	# we need to pause all of the timers that are still going.
	$GameTimer.stop()
	$SpawnTimer.stop()
