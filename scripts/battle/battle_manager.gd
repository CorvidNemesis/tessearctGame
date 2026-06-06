extends Node2D
const playerPositionsX = [1263,1525,1525,1790]
const playerPositionsY = [700,534,825,700]
const aqKey = 0;
const aqScene = 1;
const aqSpeed = 2;


@onready var battlerZoneNode = $Battlers;
@onready var camera = $BattleCam

var isEveryoneReady:bool;

var action_queue = [];

### PRE-PHASE FUNCTIONS
func _ready() -> void:
	print("Step 3.1: Put player characters in player box")
	global_battle_information.battle_signal_readyCheck.connect(is_everyone_ready);
	global_battle_information.battle_signal_phase_start_turn.connect(battle_phase_one_turn_start)

	var characters = global_battle_information.partaking_char;	#print(children)
	var index = 0;
	for key in characters:
		battlerZoneNode.add_child(characters[key])
		characters[key].global_position = Vector2(playerPositionsX[index],playerPositionsY[index]);
		index+=1;
		_assign_speed(key)
	print("Step 3.2: Put enemies in enemy box")
	for enemy in global_battle_information.partaking_enemies:
		enemy._enemy_choose_skill_simple()

func _cleanUpbattlerZoneNode()->void:
	for character in battlerZoneNode.get_children():
		if (character is BattlePlayer):
			character.queue_free();

### PHASE 0: ACTION SELECTION
func _assign_speed(key:String)->void:
	var character = global_battle_information.partaking_char[key];
	var speed = character._getStats()._get_speed();
	action_queue.append([key,character,speed]);
	 
func is_everyone_ready()->bool:
	for hero in global_battle_information.partaking_char:
		var getHero = globalVars.battler_compendium[hero][0]
		var alive = getHero._getStats()._isAlive();
		var selectedSomething = getHero.is_battle_ready();
		print("_is_everyone_ready" + "Hero:" + str(hero) + " is alive: " + str(alive) + " is acting " + str(selectedSomething))
		if !(alive and selectedSomething):
			return false
		global_battle_information.battles_can_begin = true;
	return true

func battle_phase_one_turn_start()->void:
	for entity in action_queue:
		var vs = entity[1].target[0];
		clash(entity[1],vs)
		

func clash(attacker,defender):
	print(str(attacker) + " vs " + str(defender))
	print(str(attacker.skill_chosen.name) + " vs " + str(defender.skill_chosen.name))
	attacker.skill_chosen._reset_skill()
	defender.skill_chosen._reset_skill()
	while (attacker.skill_chosen.safteyRemaining >= 0 and defender.skill_chosen.safteyRemaining >=0):
		var attackerRoll = attacker._clash_marble_roll("str")
		var defenderRoll = defender._clash_marble_roll("str")
		print(str(attackerRoll) + " vs " + str(defenderRoll))
		if (attackerRoll == defenderRoll):
			attacker.skill_chosen._clashTie()
			defender.skill_chosen._clashTie()
			print("TIED!")
		elif (attackerRoll > defenderRoll):
			defender.skill_chosen._clashLost()
			print(str(attacker) + " ranks up!")
		else:
			attacker.skill_chosen._clashLost()
			print(str(defender) + " ranks up!")
	# var winner: 
	# if attacker wins 
		#  winner = attacker
	# else:
		# winner = defender
	# defender._executeSkill()



	
	
