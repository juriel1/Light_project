extends Node

var world_scene = "res://Scenes/World.tscn"

func change_level(new_scene_path: String) -> void:
	get_tree().change_scene_to_file(new_scene_path)
	
func _on_button_pressed() -> void:
	change_level(world_scene)
