extends Node

@export var time_label:Label
var seconds
var time_to_label

func _ready() -> void:
	seconds = int(Finish.time)
	var hours = seconds / 3600
	var minutes = (seconds % 3600) / 60
	var seconds = seconds % 60
	time_to_label = "%02d:%02d:%02d" % [hours, minutes, seconds]
	time_label.text = str("Time: ", time_to_label)
