extends PanelContainer

@export var health_text:Label;
@export var magnet_text:Label;
@export var health_bar:TextureProgressBar;
@export var magnet_bar:TextureProgressBar;

var held_ace: BattleHero;

func _ready() -> void:
	pass

func _assign_battler(creature: BattleHero)->void:
	held_ace = creature;

func _update_ui():
	health_text.text = str(held_ace._get_battle_data().current_hp)
	health_bar.value = held_ace._get_battle_data().current_hp;
	health_bar.max_value = held_ace._get_battle_data().stat_dict["maxHP"][1];
	magnet_text.text = str(held_ace._get_battle_data().current_mp)
	magnet_bar.value = held_ace._get_battle_data().current_mp;
	magnet_bar.max_value = held_ace._get_battle_data().stat_dict["maxMP"][1];
