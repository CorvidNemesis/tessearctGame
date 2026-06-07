extends MarginContainer
func _make_the_card(skill:BattleSkill)->void:
	var user = gl_battle.currently_selected_hero;
	# TODO: TIDY THIS!!!!!
	$VBoxContainer/skillName.text = skill.name;
	$VBoxContainer/Description.text = skill.description;
	print($VBoxContainer/Description.text)
	
	$VBoxContainer/CurMPtoCostLabel.text = str(user._get_battle_data()._current_mp) + " / " + (str(skill.mp_cost))
	$VBoxContainer/CurMPtoCost.value = (skill.mp_cost)
	$VBoxContainer/CurMPtoCost.max_value = user._get_battle_data()._current_mp;
	
	for child in $VBoxContainer/Ailments/VBoxContainer.get_children():
		child.queue_free()
	# TODO Add status ailment code.
