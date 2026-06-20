extends PanelContainer

@export var health_text:Label;
@export var magnet_text:Label;
@export var health_bar:TextureProgressBar;
@export var magnet_bar:TextureProgressBar;

var held_hero: BattleHero;

func _ready() -> void:
	pass

func _assign_battler(creature: BattleHero)->void:
	held_hero = creature;
	self.hp_update.connect("update_hp")
	
func _update_ui():
	update_hp();
	update_mp();

func update_hp()->void:
	health_text.text = str(held_hero._get_battle_data().current_hp)
	health_bar.value = held_hero._get_battle_data().current_hp;
	health_bar.max_value = held_hero._get_battle_data().stat_dict["maxHP"][1];

func update_mp()->void:
	magnet_text.text = str(held_hero._get_battle_data().current_mp)
	magnet_bar.value = held_hero._get_battle_data().current_mp;
	magnet_bar.max_value = held_hero._get_battle_data().stat_dict["maxMP"][1];
