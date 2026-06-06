class_name BattlePlayer
extends BattleEntity

@export var battleText: quotesResource;
@export var animationEffects: AnimationPlayer;
@export var selectionButton: Button;

func _ready() -> void:
	signal_manager.hide_me.connect(_hide_self)

## returns the stats of a user.
func _getStats():
	return battle_data

### SETUP PHASE

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
		var _select_opacity_off = create_tween().tween_property(entity_sprite_sheet,"modulate:a",0.5,0.5);
	else:
		var _select_opacity_on = create_tween().tween_property(entity_sprite_sheet,"modulate:a",1,0.5);
