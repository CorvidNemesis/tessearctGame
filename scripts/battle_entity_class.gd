class_name BattleEntity
extends Node2D

@export var battle_data: statsResource;
@export var defensive_skill: BattleSkill;
@export var entity_sprite_sheet: AnimatedSprite2D;
@export var animation_effects: AnimationPlayer;
@onready var damage_number = $DamageContainer;

var skill_chosen:BattleSkill;
var targets = [];
var is_defending: bool = false;
var is_clashing: bool = true;
var living_status = true;
var mobility_status = true;

var home_position;

func _ready_for_battle():
	battle_data._current_hp = battle_data.stat_dict["maxHP"];
	battle_data._current_mp = battle_data.stat_dict["maxMP"];
	battle_data.stat_dict["battle_MHP"] = battle_data.stat_dict["maxHP"];
	battle_data.stat_dict["battle_MMP"] = battle_data.stat_dict["maxMP"];

#region Helper Functions
func _get_battle_data():
	return battle_data
#endregion

#region Battle Begin
func _reset_entity()->void:
	targets = [];
	skill_chosen = null;
	is_defending = false;
	is_clashing = true;
#endregion

#func _magpie_skill_base()->int:
	#return skill_chosen.clashBasePower;
	#
#func _magpie_roll(statKey:String)->int:
	#var finalValue = _magpie_skill_base() + battle_data._get_stat_value(statKey);
	#var result = randi_range(_magpie_skill_base(),finalValue);
	#for roller in roll_zone.get_children():
		#roller.queue_free()
	#roll_visual_instance = rolling_visual.instantiate();
	#roll_zone.add_child(roll_visual_instance);
	#roll_visual_instance._store(result);
	#roll_visual_instance.timer_trigger();
	#roll_visual_instance._remaining(skill_chosen);
	#return result;
#
#func _magpie_lose()->void:
	#pass
#
#func _magpie_tie()->void:
	#pass
#
#func _magpie_win()->void:
	#pass


#endregion
#region Battle Phases
func _turn_start():
	pass
func _action_start():
	pass
func _landing_hit():
	pass
func _on_hit():
	pass
func _turn_end():
	pass
#endregion
func _assign_home(home:Vector2)->void:
	home_position=home;

func _move_to(place:Vector2):
	var movement = create_tween();
	var target_x = place.x;
	var target_y = place.y;
	var space = 250;
	var spacing;
	if self is battleEnemy:
		print(" Enemy Action ")
		spacing = -1;
	else:
		print(" Player Action ")
		spacing = 1;
	movement.tween_property(self,"global_position",Vector2(target_x+(space)*spacing,target_y),1)
	await movement.finished

func _is_alive()->bool:
	print("Current HP:" + str(self.battle_data._current_hp))
	if (self.battle_data._current_hp <= 0):
		living_status = false;
	else:
		living_status = true;
	return living_status;

func _is_capable_to_fight()->bool:
	return true

func _is_capable_to_target()->bool:
	return true

func _change_hp(amount:int)->void:
	var _damage = amount - self.battle_data._get_stat_value("def")
	self.battle_data._current_hp -= _damage;
	gl_battle.emit_signal("battle_signal_ui_hero_hp");

func _get_speed()->int:
	return battle_data._get_speed();
