class_name BattleFiend;
extends BattleEntity

@export var damage_number: PackedScene;
@export var selection:TextureButton;
@export var damage_zone:Control;

# Range from most agressive to least agressive;
@export_enum(
	"OFFENSIVE",
	"RECOVERY",
	"SUPPORT"
	) var enemy_behavior: String;

@export_enum(
	"MASS SUMMATION",
	"EXPLOIT THE WEAK",
	"DESTORY STRONGEST",
	"CONSERVE MP"
	) var target_type: String;

#TODO: Make actual enemy targeting bro
func _enemy_choose_skill_simple()->void:
	pass;

func _on_selection_pressed() -> void:
	gl_battle.focused_hero.skill_chosen.main_target = self.index;
	gl_battle.emit_signal("package_skill")
	gl_battle.emit_signal("next_turn")
