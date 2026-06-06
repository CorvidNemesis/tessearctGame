extends Node2D
const playerPositionsX = [1263,1525,1525,1790]
const playerPositionsY = [700,534,825,700]

@onready var battlerZoneNode = $Battlers;
@onready var singleton = $Enemy/Singular;
@onready var triple = $Enemy/Triad;
@onready var quintet = $Enemy/Quintet;
@onready var camera = $BattleCam
@onready var clash_manager = $ClashManager

enum ENEMYPOSITIONS {
	SINGLETON,
	TRIPLE,
	QUINTET
}

var heroes;
var enemies;
var enemy_formation;

var isEveryoneReady:bool;
var all_participants = [];
var incapacitated = [];
var action_queue = [];

### PRE-PHASE FUNCTIONS
func _ready() -> void:
	heroes = global_battle_information.partaking_heroes;
	enemies = global_battle_information.partaking_enemies
	print("Step 3.1: Put player characters in player box")
	global_battle_information.battle_signal_readyCheck.connect(is_everyone_ready);
	global_battle_information.battle_signal_phase_start_turn.connect(battle_phase_one_turn_start)
	var index = 0;
	for hero in heroes:
		#TODO: REPLACE WITH GOLBAL CONSTANT
		var current_hero = hero[1]
		battlerZoneNode.add_child(current_hero)
		current_hero.global_position = Vector2(playerPositionsX[index],playerPositionsY[index]);
		index+=1;
	print("Step 3.2: Put enemies in enemy box")
	if (enemies.size() == 1):
		enemy_formation = ENEMYPOSITIONS.SINGLETON;
	elif (enemies.size()==3):
		enemy_formation = ENEMYPOSITIONS.TRIPLE;
	else:
		enemy_formation = ENEMYPOSITIONS.QUINTET
	all_participants.append_array(heroes)
	all_participants.append_array(enemies)
	place_enemies()
	battle_phase_zero()

func place_enemies()->void:
	var targetArea;
	if (enemy_formation == ENEMYPOSITIONS.SINGLETON):
		targetArea = singleton;
	elif (enemy_formation == ENEMYPOSITIONS.TRIPLE):
		targetArea = triple;
	else:
		targetArea = quintet;
	var arange = get_positions(targetArea);
	var index = 0;
	for enemy in enemies:
		var current_enemy = enemy[1];
		print(targetArea)
		targetArea.add_child(current_enemy)
		current_enemy.global_position = arange[index];
		index+=1;
	
func _clean_enemy_zone(zone:Node2D)->void:
	for enemy in zone.get_children():
		if enemy is BattleEntity:
			enemy.queue_free();
		else:
			enemy.hide();

func get_positions(zone:Node2D):
	var positions = []
	_clean_enemy_zone(zone)
	print(zone)
	for placementBox in zone.get_children():
		print(placementBox)
		print(placementBox.global_position)
		positions.append(placementBox.global_position)
	print(positions)
	return positions
	
			
			
		#enemy._enemy_choose_skill_simple()
	#all_participants.append_array(global_battle_information.partaking_heroes)
	#all_participants.append_array(global_battle_information.partaking_enemies)

func _clean_up_hero_zone()->void:
	for character in battlerZoneNode.get_children():
		if (character is BattlePlayer):
			character.queue_free();

### PHASE 0: ACTION SELECTION
func _assign_speed()->void:
	action_queue.clear();
	for entity in all_participants:
		if (entity[1]._isAlive() and entity[1]._is_capable_to_fight()):
			entity[global_battle_information.ACTION_QUEUE_SPEED] = entity[1]._get_speed();
			action_queue.append(entity);
		elif (!entity._isAlive()):
			incapacitated.append(entity)
	action_queue.sort_custom(sort_ascending)
	print(action_queue)

func sort_ascending(a, b):
	if a[global_battle_information.ACTION_QUEUE_SPEED] < b[global_battle_information.ACTION_QUEUE_SPEED]:
		return true
	return false

func is_everyone_ready()->bool:
	for hero in heroes:
		var getHero = hero[1]
		var alive = getHero._isAlive();
		var selectedSomething = getHero._is_battle_ready();
		print("_is_everyone_ready" + "Hero:" + str(hero) + " is alive: " + str(alive) + " is acting " + str(selectedSomething))
		if !(alive and selectedSomething):
			return false
		global_battle_information.battles_can_begin = true;
	return true


func battle_phase_zero()->void:
	print("///////////////////////////// PHASE ZERO ///////////////////////////// ")
	for enemy in enemies:
		enemy[1]._enemy_choose_skill_simple();
	_assign_speed()
	
func battle_phase_one_turn_start()->void:
	print("///////////////////////////// PHASE ONE ///////////////////////////////")
	print(action_queue)
	for entity in action_queue:
		print(entity[1]._get_battle_data().display_name + " is acting now.")
		clash_manager.clash(entity[1],entity[1].targets[0])
		
