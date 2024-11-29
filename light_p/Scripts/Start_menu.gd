extends Node

var intro_scene = "res://Scenes/Intro.tscn"
var credits_scene = "res://Scenes/Credits.tscn"

func change_level(new_scene_path: String) -> void:
	get_tree().change_scene_to_file(new_scene_path)

func _on_start_pressed() -> void:
	change_level(intro_scene)
	

func _on_credits_pressed() -> void:
	change_level(credits_scene)
