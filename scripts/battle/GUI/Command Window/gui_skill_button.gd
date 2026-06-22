extends Button

var held_skill:BattleSkill;

signal set_description(text:String)

func _create_skill(skill:BattleSkill)->void:
	held_skill = skill;
	self.text = held_skill.name
	self.show()

func _on_mouse_entered() -> void:
	set_description.emit(held_skill.description)

func _on_pressed() -> void:
	gl_battle.focused_hero._set_skill(held_skill)
	gl_battle.emit_signal("assign_skill")
