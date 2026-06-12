class_name BattlePlayer
extends BattleEntity

enum Placement {
	FRONT = 0,
	CENTER = 1,
	BACK = 2
}

const PLACEMENT_EFFECTS = [1.5,1.0,0.5]

func _ready() -> void:
	signal_manager.hide_me.connect(_hide_self)
	pass

### SETUP PHASE
func _is_battle_ready()-> bool:
	if (((self.skill_chosen != null) and !self.targets.is_empty()) or is_defending):
		return true
	return false

func _on_selection_pressed() -> void:
	gl_battle.currently_selected_hero = self;
	gl_battle.emit_signal("battle_signal_open_actions")
	signal_manager.emit_signal("focus_on_me",self.global_position.x,self.global_position.y,150)
	signal_manager.emit_signal("hide_me")
	
func _hide_self()->void:
	if (self.scene_file_path != gl_battle.currently_selected_hero.scene_file_path):
		var _select_opacity_off = create_tween().tween_property(self.entity_sprite_sheet,"modulate:a",0.5,0.5);
	else:
		var _select_opacity_on = create_tween().tween_property(self.entity_sprite_sheet,"modulate:a",1,0.5);
