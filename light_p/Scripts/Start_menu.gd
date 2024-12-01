extends Node

var intro_scene = "res://Scenes/Intro.tscn"
var credits_scene = "res://Scenes/Credits.tscn"

@export var label:Label
@export var start:Button
@export var credits:Button
@export var logo:Sprite2D
@export var background:Sprite2D

var origin_scale = 1078
var factor:float

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	factor = float(window_size.x)/origin_scale
	viewport.size = window_size
	
	background.scale = Vector2(background.scale.x*factor, background.scale.y*factor)
	background.position = Vector2((background.position.x*factor)-150,(background.position.y*factor)-150)
	logo.scale = Vector2(logo.scale.x*factor, logo.scale.y*factor)
	logo.position = Vector2(logo.position.x*factor,logo.position.y*factor)

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
