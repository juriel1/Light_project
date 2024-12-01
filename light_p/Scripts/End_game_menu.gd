extends Node

@export var time_label:Label
@export var background:Sprite2D

var seconds
var time_to_label
var origin_scale = 1078
var factor:float

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	factor = float(window_size.x)/origin_scale
	viewport.size = window_size
	background.scale = Vector2(background.scale.x*factor, background.scale.y*factor)
	background.position = Vector2((background.position.x*factor)-150,(background.position.y*factor)-150)
	
	seconds = int(Finish.time)
	var hours = seconds / 3600
	var minutes = (seconds % 3600) / 60
	var seconds = seconds % 60
	time_to_label = "%02d:%02d:%02d" % [hours, minutes, seconds]
	time_label.text = str("Time: ", time_to_label)
