extends Node

func go_to_scene(target:String)->void:
	var loading_screen = preload("res://scenes/Loading Screen.tscn").instantiate()
	loading_screen.next_scene_path = target
	get_tree().current_scene.add_child(loading_screen)
