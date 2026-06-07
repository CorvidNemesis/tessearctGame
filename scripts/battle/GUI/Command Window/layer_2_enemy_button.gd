extends Button

var connected_enemy
# Called when the node enters the scene tree for the first time.
func _setup(enemy:Array)->void:
	self.text = enemy[1].name;
	connected_enemy = enemy;
	print("_setup " + str(connected_enemy))

func _on_pressed() -> void:
	print("_on_pressed Button Pressed!")
	gl_battle.currently_selected_hero.targets.append(connected_enemy);
	gl_battle.emit_signal("battle_signal_readyCheck") # Replace with function body.
