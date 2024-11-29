extends Node3D

var is_paused: bool = false
@export var canvas:CanvasLayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_pause()

func toggle_pause() -> void:
	is_paused = !is_paused
	if is_paused:
		print("pause")
		canvas.on_pause()
	else:
		print("des pause")
		canvas.off_pause()
	get_tree().paused = is_paused
