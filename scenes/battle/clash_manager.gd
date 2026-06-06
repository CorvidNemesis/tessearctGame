extends Node

func clash(attacker,defender):
	print("/////////////// CLASH ///////////////")
	print(str(attacker._get_battle_data().display_name) + " vs " + str(defender._get_battle_data().display_name))
	print(str(attacker.skill_chosen.name) + " vs " + str(defender.skill_chosen.name))
	var outgoing = attacker.skill_chosen;
	var recipient = defender.skill_chosen;
	outgoing._reset_skill()
	recipient.skill_chosen._reset_skill()
	var winner 
	# if attacker wins 
		#  winner = attacker
	# else:
		# winner = defender
	# defender._executeSkill()
