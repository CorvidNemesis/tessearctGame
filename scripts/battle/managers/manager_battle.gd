extends Node2D

@onready var magpie_manager = $ClashManager
@onready var damage_manager = $"DamageManager";
@onready var battle_camera = $BattleCam;

enum ENEMYPOSITIONS {
	SINGLETON,
	TRIPLE,
	QUINTET
}

#region Variables
var heroes;
var enemies;
var enemy_formation;
var isEveryoneReady:bool;
var all_participants = [];
var incapacitated = [];
var action_queue = [];

var heroes_alive = true;
#endregion

var brawling = false;

### PRE-PHASE FUNCTIONS
func _ready() -> void:
	heroes = gl_battle.partaking_heroes;
	enemies = gl_battle.partaking_enemies
	gl_battle.battle_signal_readyCheck.connect(is_everyone_ready);
	gl_battle.battle_signal_phase_start_turn.connect(battle_loop)
	var index = 0;
	for hero in heroes:
		var current_hero:BattlePlayer = hero[gl_battle.AQ_SCENE_INDEX]
		current_hero._ready_for_battle();
		index+=1;
	if (enemies.size() == 1):
		enemy_formation = ENEMYPOSITIONS.SINGLETON;
	elif (enemies.size()==3):
		enemy_formation = ENEMYPOSITIONS.TRIPLE;
	else:
		enemy_formation = ENEMYPOSITIONS.QUINTET
	all_participants.append_array(heroes)
	all_participants.append_array(enemies)
	action_phase()

func _clean_enemy_zone(zone:Node2D)->void:
	for enemy in zone.get_children():
		if enemy is BattleEntity:
			enemy.queue_free();
		else:
			enemy.hide();

func get_positions(zone:Node2D):
	var positions = []
	_clean_enemy_zone(zone)
	for placementBox in zone.get_children():
		positions.append(placementBox.global_position)
	return positions

func _assign_speed()->void:
	action_queue.clear();
	for entity in all_participants:
		if (entity[gl_battle.AQ_SCENE_INDEX]._is_alive() and entity[gl_battle.AQ_SCENE_INDEX]._is_capable_to_fight()):
			entity[gl_battle.AQ_SPEED_INDEX] = entity[gl_battle.AQ_SCENE_INDEX]._get_speed();
			action_queue.append(entity);
		elif (!entity[gl_battle.AQ_SCENE_INDEX]._is_alive()):
			incapacitated.append(entity)
	action_queue.sort_custom(sort_ascending)

func sort_ascending(a, b):
	if a[gl_battle.AQ_SPEED_INDEX] > b[gl_battle.AQ_SPEED_INDEX]:
		return true
	return false

func is_everyone_ready()->bool:
	for hero in heroes:
		var getHero = hero[1]
		var alive = getHero._is_alive();
		var selectedSomething = getHero._is_battle_ready();
		print("_is_everyone_ready" + "Hero:" + str(hero) + " is alive: " + str(alive) + " is acting " + str(selectedSomething))
		if !(alive and selectedSomething):
			return false
		gl_battle.battles_can_begin = true;
	return true

#region Battle
func action_phase():
	battle_camera._reset_camera();
	_assign_speed()
	for enemy in enemies:
		var enemy_scene:battleEnemy = enemy[gl_battle.AQ_SCENE_INDEX]
		if enemy_scene._is_alive():
			enemy_scene._enemy_choose_skill_simple();

func battle_loop():
	battle_camera._reset_camera();
	await get_tree().create_timer(1).timeout
	print("///////////////////// TURN /////////////////////")
	for entity in action_queue:
		var entity_scene:BattleEntity = entity[gl_battle.AQ_SCENE_INDEX];
		entity_scene._move_to(entity_scene.targets[0][1].global_position);
		await damage_manager._execute_damage_skill(entity_scene,entity_scene.skill_chosen)
		await entity_scene._move_to(entity_scene.home_position);
	action_phase()
#endregion
