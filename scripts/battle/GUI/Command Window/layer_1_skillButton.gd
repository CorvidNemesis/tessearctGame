extends Button

var skill: BattleSkill

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _skillMaker(index:int)->void:
	skill = global_battle_information.currently_selected_hero._getStats().skillSet[index];
	self.text = skill.name;
	print(self.text)

func _on_pressed() -> void:
	global_battle_information.currently_selected_hero.skill_chosen = skill;
	global_battle_information.emit_signal("battle_signal_makeSkillCard",skill)
