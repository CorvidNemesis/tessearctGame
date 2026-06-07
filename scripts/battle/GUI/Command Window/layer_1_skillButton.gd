extends Button

var skill: BattleSkill

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _skillMaker(index:int)->void:
	skill = gl_battle.currently_selected_hero._get_battle_data().skillSet[index];
	self.text = skill.name;
	print(self.text)

func _on_pressed() -> void:
	gl_battle.currently_selected_hero.skill_chosen = skill;
	gl_battle.emit_signal("battle_signal_makeSkillCard",skill)
