extends Node2D
const playerPositionsX = [1263,1525,1525,1790]
const playerPositionsY = [700,534,825,700]

@onready var battlerZoneNode = $Battlers;
@onready var singleton = $Enemy/Singular;
@onready var triple = $Enemy/Triad;
@onready var quintet = $Enemy/Quintet;
@onready var camera = $BattleCam
@onready var magpie_manager = $ClashManager
@onready var damage_manager = $"DamageManager";

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
	heroes = gl_battle.partaking_heroes;
	enemies = gl_battle.partaking_enemies
	print("Step 3.1: Put player characters in player box")
	gl_battle.battle_signal_readyCheck.connect(is_everyone_ready);
	gl_battle.battle_signal_phase_start_turn.connect(battle_phase_one_turn_start)
	var index = 0;
	for hero in heroes:
		#TODO: REPLACE WITH GOLBAL CONSTANT
		var current_hero = hero[1]
		current_hero._battle_phase_setup();
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
		current_enemy._battle_phase_setup();
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
	#all_participants.append_array(gl_battle.partaking_heroes)
	#all_participants.append_array(gl_battle.partaking_enemies)

func _clean_up_hero_zone()->void:
	for character in battlerZoneNode.get_children():
		if (character is BattlePlayer):
			character.queue_free();

### PHASE 0: ACTION SELECTION
func _assign_speed()->void:
	action_queue.clear();
	for entity in all_participants:
		if (entity[gl_battle.AQ_SCENE_INDEX]._isAlive() and entity[gl_battle.AQ_SCENE_INDEX]._is_capable_to_fight()):
			entity[gl_battle.AQ_SPEED_INDEX] = entity[gl_battle.AQ_SCENE_INDEX]._get_speed();
			action_queue.append(entity);
		elif (!entity[gl_battle.AQ_SCENE_INDEX]._isAlive()):
			incapacitated.append(entity)
	action_queue.sort_custom(sort_ascending)

func sort_ascending(a, b):
	if a[gl_battle.AQ_SPEED_INDEX] > b[gl_battle.AQ_SPEED_INDEX]:
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
		gl_battle.battles_can_begin = true;
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
		var entity_scene = entity[gl_battle.AQ_SCENE_INDEX]
		var entity_home = entity_scene.global_position;
		var target_home = entity_scene.targets[0][gl_battle.AQ_SCENE_INDEX].global_position;
		if !(entity_scene.is_clashing):
			print("Unable to attack!")
			pass
		else:
			if !(entity_scene.targets[0][gl_battle.AQ_SCENE_INDEX].is_clashing):
				damage_manager._execute_damage_skill(
					entity_scene,entity_scene.skill_chosen)
			# calculate_places(entity[gl_battle.AQ_SCENE_INDEX],entity[gl_battle.AQ_SCENE_INDEX].targets[0][1]);
			var magpie = await magpie_manager.magpie(entity[gl_battle.AQ_SCENE_INDEX],entity[gl_battle.AQ_SCENE_INDEX].targets[0][1])
			magpie[0].is_clashing = false;
			damage_manager._execute_damage_skill(magpie[0],magpie[0].skill_chosen);

func calculate_places(entity,target)->void:
	var middle_x = (entity.global_position.x + target.global_position.x)/2
	var middle_y = (entity.global_position.y + target.global_position.y)/2
	var middleZone = Vector2(middle_x,middle_y)
	var movement = create_tween().set_parallel(true);
	movement.tween_property(entity,"global_position",middleZone,0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
	movement.tween_property(target,"global_position",middleZone,0.5).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_IN)
