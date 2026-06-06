extends MarginContainer
func _make_the_card(skill:BattleSkill)->void:
	var user = global_battle_information.currently_selected_hero;
	# TODO: TIDY THIS!!!!!
	print("_make_the_card")
	print()
	print("Making card for skill: " + str(skill))
	$VBoxContainer/skillName.text = skill.name;
	$VBoxContainer/Description.text = skill.description;
	print($VBoxContainer/Description.text)
	
	#$VBoxContainer/MaxMPtoCostLabel.text = str(user._getStats().stat_dict["maxMP"]) + " / " + (str(skill.cost))
	#$VBoxContainer/MaxMPtoCost.value = (skill.cost)
	#$VBoxContainer/MaxMPtoCost.max_value = user._getStats().stat_dict["maxMP"]
	
	$VBoxContainer/CurMPtoCostLabel.text = str(user._getStats().stat_current_MP) + " / " + (str(skill.mp_cost))
	$VBoxContainer/CurMPtoCost.value = (skill.mp_cost)
	$VBoxContainer/CurMPtoCost.max_value = user._getStats().stat_current_MP;
	
	for child in $VBoxContainer/Ailments/VBoxContainer.get_children():
		child.queue_free()
	# TODO Add status ailment code.
	print("I MADE THE CARD ARE YOU PROUD OF ME!?")
