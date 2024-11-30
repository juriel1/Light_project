extends Area3D


var end_game_scene = "res://Scenes/End_game.tscn"
@export var label:Label
var time:float

func _ready() -> void:
	self.connect("body_exited", Callable(self, "_on_body_exited"))
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	
func _process(delta: float) -> void:
	time += delta
	
func change_level(new_scene_path: String) -> void:
	get_tree().change_scene_to_file(new_scene_path)
	
func _on_body_entered(body):
	if body.name == "Player":
		if body.end_game() == true:
			change_level(end_game_scene)
		else:
			label.text = "There are still 
treasures missing"
func _on_body_exited(body):
	if body.name == "Player":
		label.text = ""
