extends VBoxContainer

@export var skillButton: PackedScene;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	global_battle_information.battle_signal_prepareSkillset.connect(setupSkills);
	cleanUp();

func cleanUp()->void:
	for child in get_children():
		child.queue_free();

func setupSkills()->void:
	cleanUp();
	print("SettingUpSkills")
	var skills = global_battle_information.currently_selected_hero._getStats().skillSet;
	var count = 0;
	for skill in skills:
		print(skill)
		var skill_instance = skillButton.instantiate();
		add_child(skill_instance);
		skill_instance._skillMaker(count)
		count +=1
	for child in get_children():
		child.show;
	print(get_children())
	print(get_child_count())
 # Replace with function body.
