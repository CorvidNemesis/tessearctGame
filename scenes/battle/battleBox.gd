extends PanelContainer

var asc_battler: battlePlayer;
@onready var display_name: Label;
@onready var display_HP: Label;
@onready var display_MP: Label;

func _ready() -> void:
	display_name = get_node("MarginContainer/VBoxContainer/Name")
	display_HP = get_node("MarginContainer/VBoxContainer/HBoxContainer/HPBox/HP")
	display_MP = get_node("MarginContainer/VBoxContainer/HBoxContainer/MPBox/MP")
	

func _assign_battler(creature: battlePlayer)->void:
	asc_battler = creature;

func _setup_displayables(name:String,hp:int,mp:int,cf:int) -> void:
	display_name.text = name;
	display_HP.text = "LS:" + str(hp) + "/" + str(hp);
	display_MP.text = "MP:" + str(mp) + "/" + str(mp);


func _on_player_face_pressed() -> void:
	print("Among_Us")
	pass # Replace with function body.
