extends PanelContainer

var asc_battler: BattlePlayer;
@onready var display_name: Label;
@onready var display_HP: Label;
@onready var display_MP: Label;

func _ready() -> void:
	display_HP = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProgressBar/HP")
	display_MP = get_node("MarginContainer/VBoxContainer/HBoxContainer/ProgressBar2/MP")
	
func _assign_battler(creature: BattlePlayer)->void:
	asc_battler = creature;

func _setup_displayables(name:String,hp:int,mp:int) -> void:
	display_HP.text = "LS:" + str(hp) + "/" + str(hp);
	display_MP.text = "MP:" + str(mp) + "/" + str(mp);
