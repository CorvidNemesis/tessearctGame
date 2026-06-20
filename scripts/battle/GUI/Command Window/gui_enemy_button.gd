extends Button
var held_enemy:BattleFiend;
var index:int;
signal target(enemy:BattleFiend)

func _create_enemy(enemy:BattleFiend,index:int)->void:
	self.index = index;
	self.text = enemy.name
	self.show()
	
func _on_pressed() -> void:
	print("SELECTED ENEMY!")
	gl_battle.emit_signal("targeting",index)
