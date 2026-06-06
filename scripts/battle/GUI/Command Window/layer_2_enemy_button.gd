extends Button

var connected_enemy
# Called when the node enters the scene tree for the first time.
func _setup(enemy:battleEnemy)->void:
	self.text = enemy.name;
	connected_enemy = enemy;
	print("_setup " + str(connected_enemy))

func _on_pressed() -> void:
	print("_on_pressed Button Pressed!")
	global_battle_information.currently_selected_hero.targets.append(connected_enemy);
	global_battle_information.emit_signal("battle_signal_readyCheck") # Replace with function body.
