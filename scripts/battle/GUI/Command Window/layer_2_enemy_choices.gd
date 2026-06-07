extends GridContainer

@export var enemyButton: PackedScene;

func _ready() -> void:
	cleanUp();

## Clears out all enemy buttons as to not overlap with new ones.
func cleanUp()->void:
	for item in get_children():
		item.queue_free();
	
## Adds enemy buttons to itself.
func _setup_enemies()->void:
	cleanUp();
	for enemy in gl_battle.partaking_enemies:
		var enemyButtonInstance = enemyButton.instantiate();
		self.add_child(enemyButtonInstance);
		enemyButtonInstance._setup(enemy)
