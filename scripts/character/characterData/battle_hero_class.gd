class_name BattlePlayer
extends BattleEntity

enum Placement {
	FRONT = 0,
	CENTER = 1,
	BACK = 2
}

const PLACEMENT_EFFECTS = [1.5,1.0,0.5]
@export var selectionButton: Button;

func _ready() -> void:
	#signal_manager.hide_me.connect(_hide_self)
	pass

## returns the stats of a user.
func _getStats():
	return battle_data

### SETUP PHASE
func _is_battle_ready()-> bool:
	if (((self.skill_chosen != null) and !self.targets.is_empty()) or is_defending):
		return true
	return false
### BATTLE PHASE

func _on_selection_pressed() -> void:
	global_battle_information.currently_selected_hero = self;
	global_battle_information.emit_signal("battle_signal_openActions")
	signal_manager.emit_signal("focus_on_me",self,self.position.x,self.position.y)
	signal_manager.emit_signal("hide_me")
	
# func _hide_self()->void:
	#if (self.scene_file_path != global_battle_information.currently_selected_hero.scene_file_path):
		#var _select_opacity_off = create_tween().tween_property(entity_sprite_sheet,"modulate:a",0.5,0.5);
	#else:
		#var _select_opacity_on = create_tween().tween_property(entity_sprite_sheet,"modulate:a",1,0.5);
