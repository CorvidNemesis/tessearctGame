extends CanvasLayer

@export var battleBox: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cleanUp_ui();
	setup_battlers(globalBattleInfo.partaking_char);

func cleanUp_ui()-> void:
	for box in $"MarginContainer/BoxZone/Player Window".get_children():
		box.queue_free();

func setup_battlers(partakingList: Array)->void:
	var count = 1;
	for battler in partakingList:
		print(battler)
		var box_instance = battleBox.instantiate();
		var stats = battler._getStats();
		$"MarginContainer/BoxZone/Player Window".add_child(box_instance);
		box_instance._setup_displayables(stats.display_name + str(count),stats.stat_dict["maxHP"],stats.stat_dict["maxMP"],50)
		count +=1;

		
