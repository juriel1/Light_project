extends Node

var menu_scene = "res://Scenes/Start_menu.tscn"

func change_level(new_scene_path) -> void:
	get_tree().change_scene_to_file(new_scene_path)

func _on_back_pressed() -> void:
	change_level(menu_scene)
