extends Node

var intro_scene = "res://Scenes/Intro.tscn"
var credits_scene = "res://Scenes/Credits.tscn"

@export var label:Label
@export var start:Button
@export var credits:Button
@export var logo:Sprite2D

func _ready() -> void:
	await get_tree().create_timer(3.5).timeout
	logo.visible = false
	label.visible = true
	start.visible = true
	credits.visible = true

func change_level(new_scene_path: String) -> void:
	get_tree().change_scene_to_file(new_scene_path)

func _on_start_pressed() -> void:
	change_level(intro_scene)
	
func _on_credits_pressed() -> void:
	change_level(credits_scene)
