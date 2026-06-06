class_name BattlePlayer
extends Node2D

@export var battle_data: statsResource;
@export var battleText: quotesResource;
@export var defensive: BattleSkill;

@export var spriteSheet: AnimatedSprite2D;
@export var animationEffects: AnimationPlayer;
@export var selectionButton: Button;
@export var dialouge: Label;

func _ready() -> void:
	signal_manager.hide_me.connect(_hide_self)

## returns the stats of a user.
func _getStats():
	return battle_data

### SETUP PHASE
## Sets up a character for a turn starting
func _battle_phase_setup()->void:
	target = [];
	is_defending = false;
## The skill the battler uses.
var skill_chosen:BattleSkill;
## Uses an array to loop over multiple targets.
var target = [];
## Whether or not the character is defending or not.
var is_defending: bool = false;
## Checks if a character is battleReady
func is_battle_ready()-> bool:
	if (((self.skill_chosen != null) and !self.target.is_empty()) or is_defending):
		return true
	return false

### BATTLE PHASE
func helper_battle_getBasePower()->int:
	return skill_chosen.clashBasePower;

func _clash_marble_roll(statKey:String)->int:
	var finalValue = helper_battle_getBasePower() + battle_data._get_stat_value(statKey);
	return randi_range(helper_battle_getBasePower(),finalValue);
	# TODO: Remmeber counter and defense dice! Make em unique

func _on_selection_pressed() -> void:
	global_battle_information.currently_selected_hero = self;
	global_battle_information.emit_signal("battle_signal_openActions")
	signal_manager.emit_signal("focus_on_me",self,self.position.x,self.position.y)
	signal_manager.emit_signal("hide_me")
	
func _hide_self()->void:
	if (self.scene_file_path != global_battle_information.currently_selected_hero.scene_file_path):
		var _select_opacity_off = create_tween().tween_property(spriteSheet,"modulate:a",0.5,0.5);
	else:
		var _select_opacity_on = create_tween().tween_property(spriteSheet,"modulate:a",1,0.5);

### BATTLE PHASE
func execute_skill()->void:
	for hit in range(skill_chosen.hit_count):
		var stat_choice = battle_data.source_stat_array[skill_chosen.stat_power];
		var damage = skill_chosen._getDamageAmount(stat_choice);
		for targeting in target:
			target._change_hp(damage)
			print(target.stat_current_hp)

func _change_hp(amount:int)->void: 
	battle_data.stat_current_HP -= amount;
### HELPERS
func _helper_clear_skill()->void:
	self.skill_chosen = null;
