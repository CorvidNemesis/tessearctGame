extends Node

@onready var enemyZone = $"../EnemyGroup"
@onready var playerZone = $"../PlayerGroup"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var characters = globalBattleInfo.partaking_char;
	print(characters)
	for character in characters.size():
		playerZone.add_child(characters[character]);
	print("Step 3.1: Put player characters in player box")
	var enemies = globalBattleInfo.partaking_enemies;
	for enemy in enemies.size():
		enemyZone.add_child(enemies[enemy]);
	print("Step 3.2: Put enemies in enemy box")
