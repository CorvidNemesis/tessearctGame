extends Control

func _on_start_game_pressed() -> void:
	print("ready")
	global_functions.go_to_scene("res://scenes/character_selector.tscn") # Replace with function body.
