extends VBoxContainer

@export var skillButton: PackedScene;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	gl_battle.battle_signal_prepareSkillset.connect(setupSkills);
	cleanUp();

func cleanUp()->void:
	for child in get_children():
		child.queue_free();

func setupSkills()->void:
	cleanUp();
	print("SettingUpSkills")
	var skills = gl_battle.currently_selected_hero._get_battle_data().skillSet;
	var count = 1;
	for skill in skills.size()-1:
		var skill_instance = skillButton.instantiate();
		add_child(skill_instance);
		skill_instance._skillMaker(skill+1)
	for child in get_children():
		child.show();
	print(get_children())
	print(get_child_count())
 # Replace with function body.
