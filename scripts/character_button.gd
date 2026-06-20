extends TextureButton

var held_battler:BattleHero;
@onready var info_button:Button = $HBoxContainer/Info

signal transfer_moveset()
signal select()

func _ready() -> void:
	pass

func _on_info_pressed() -> void:
	transfer_moveset.emit(held_battler.battle_data.skillSet) 


func _on_pressed() -> void:
	select.emit(self) # Replace with function body.
