extends Node2D

@onready var state_machine = $BattleStateMachine;
@onready var gui = $battleGUI;
@onready var enemy_zone = $EnemyCase;
@onready var damage_manager = $"Damage Manager";


var combat_level = 0;
var combat_gauge_value = 0;

var heroes: Array = [];
var waves: Array = [];
var current_wave: Array = [];
var all_participants: Array = [];
var action_queue: Array = [];
var heroes_alive = true;

func _ready() -> void:
	heroes = gl_battle.partaking_heroes;
	current_wave = gl_battle.partaking_enemies;
	all_participants.append_array(heroes)
	all_participants.append_array(current_wave)
	_assign_index()
	clear_enemies()
	deploy_enemies()
	gl_battle.package_skill.connect(create_action)
	state_machine._activate();

func deploy_enemies()->void:
	clear_enemies();
	for enemy:BattleFiend in current_wave:
		var new_holder = Control.new();
		new_holder.add_child(enemy)
		new_holder.size_flags_horizontal = Control.SIZE_SHRINK_CENTER | Control.SIZE_EXPAND
		new_holder.size_flags_vertical = Control.SIZE_SHRINK_CENTER
		enemy_zone.add_child(new_holder);

func clear_enemies()->void:
	for enemy in enemy_zone.get_children():
		enemy.queue_free()

func sort_ascending(a, b):
	if a[gl_battle.AQ_SPEED_INDEX] > b[gl_battle.AQ_SPEED_INDEX]:
		return true
	return false

func _return_heroes()->Array:
	return heroes

func _return_enemies()->Array:
	return current_wave

func _return_combat_gauge_value()->int:
	return combat_gauge_value;

func _return_hero(index:int)->BattleHero:
	return heroes[index]

func create_action():
	var user:BattleEntity = gl_battle.focused_hero
	var user_skill = user.skill_chosen
	var target_group = damage_manager.group_targets(
		user_skill.main_target,
		user_skill.target,
		user_skill.aimed_at)
	action_queue.push_front(
		skill_use.bind(user,user.skill_chosen,target_group)
	)

func skill_use(caster:BattleEntity,skill:BattleSkill,targets:Array)->void:
	print(caster.battle_data.display_name + " used: " + skill.name + " on " + str(targets))
	damage_manager.calculate_damage(caster,skill,targets)

func _assign_index()->void:
	var index_value = 0;
	for enemy:BattleEntity in current_wave:
		enemy.index = index_value;
		index_value+=1;
	index_value = 0;
	for hero:BattleEntity in heroes:
		hero.index = index_value;
		index_value+=1;
