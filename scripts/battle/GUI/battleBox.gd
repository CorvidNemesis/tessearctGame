extends PanelContainer

var asc_battler: BattlePlayer;
@onready var display_name:Label;
@onready var display_HP = $MarginContainer/VBoxContainer/HBoxContainer/ProgressBar/HP;
@onready var display_MP = $MarginContainer/VBoxContainer/HBoxContainer/ProgressBar2/MP;
@onready var display_HP_bar = $MarginContainer/VBoxContainer/HBoxContainer/ProgressBar;
@onready var display_MP_bar = $MarginContainer/VBoxContainer/HBoxContainer/ProgressBar2;


func _ready() -> void:
	gl_battle.battle_signal_ui_hero_hp.connect(_update_ui);

func _assign_battler(creature: BattlePlayer)->void:
	asc_battler = creature;

func _setup_displayables(hero_name:String,hp:int,mp:int) -> void:
	display_HP.text = "LS:" + str(hp)
	display_MP.text = "MP:" + str(mp)
	display_HP_bar.max_value = asc_battler.battle_data.stat_dict["battle_MHP"];
	display_MP_bar.max_value = asc_battler.battle_data.stat_dict["battle_MMP"];

func _update_ui():
	display_HP.text = "LS:" + str(asc_battler.battle_data._current_hp)
	display_MP.text = "MP:" + str(asc_battler.battle_data._current_mp)
	display_HP_bar.value = asc_battler.battle_data._current_hp;
	display_MP_bar.value = asc_battler.battle_data._current_mp;
