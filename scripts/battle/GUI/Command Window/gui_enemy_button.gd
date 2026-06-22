extends Button
var held_enemy:BattleFiend;
var index:int;

func _create_enemy(enemy:BattleFiend,enemy_index:int)->void:
	self.index = enemy_index;
	self.text = enemy.name
	self.show()
	
func _on_pressed() -> void:
	print("SELECTED ENEMY!")
	gl_battle.focused_hero._set_skill_target(index)
	gl_battle.emit_signal("targeting")
