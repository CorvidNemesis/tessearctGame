extends CanvasLayer

@export var battleBox: PackedScene
@onready var actionBox = $Actions;
var origin:Vector2;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = actionBox.global_position
	global_battle_information.battle_signal_openActions.connect(_showMenu)
	cleanUp_ui();
	setup_battlers(global_battle_information.partaking_char);

# TODO set filepath to a variable

func cleanUp_ui()-> void:
	for box in $"MarginContainer/BoxZone/Player Window".get_children():
		box.queue_free();

func setup_battlers(partaking: Dictionary)->void:
	var count = 1;
	for battler in partaking:
		var box_instance = battleBox.instantiate();
		var stats = partaking[battler]._getStats();
		$"MarginContainer/BoxZone/Player Window".add_child(box_instance);
		box_instance._setup_displayables(stats.display_name + str(count),stats.stat_dict["maxHP"],stats.stat_dict["maxMP"])
		count +=1;

func _showMenu()->void:
	var _tween = create_tween().tween_property(actionBox,"position",Vector2(origin.x,origin.y+actionBox.size.y),0.5);
	# sets up the skill box beforehand.
	# idk if this was inovative or really stupid.
	# TODO: exchange the emit signal for a function in the battleCommands menu
	global_battle_information.emit_signal("battle_signal_prepareSkillset")
	actionBox.layer = 0;
	actionBox.layer_check();
	actionBox.show()


func _on_begin_button_pressed() -> void:
	print("3 2 1 Go!")
	global_battle_information.emit_signal("battle_signal_phase_start_turn")
