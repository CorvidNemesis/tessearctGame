extends Node2D

var partaking_char = [];
var partaking_enemies = [];

func _queueParticipants(battler:battlePlayer)-> void:
	print("Step 2.1: Queue player characters into scene")
	partaking_char.append(battler);
	
func _queueEnemies(enemy:battleEnemy)-> void:
	print("Step 2.2: Queue enemies into scene")
	partaking_enemies.append(enemy);	
