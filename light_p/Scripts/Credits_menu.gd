extends Node

var menu_scene = "res://Scenes/Start_menu.tscn"
var origin_scale = 1078
var factor:float
@export var background:Sprite2D

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	factor = float(window_size.x)/origin_scale
	viewport.size = window_size
	background.scale = Vector2(background.scale.x*factor, background.scale.y*factor)
	background.position = Vector2((background.position.x*factor)-150,(background.position.y*factor)-150)

func change_level(new_scene_path) -> void:
	get_tree().change_scene_to_file(new_scene_path)

func _on_back_pressed() -> void:
	change_level(menu_scene)
