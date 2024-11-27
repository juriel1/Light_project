extends Area3D


func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	
func _on_body_entered(body):
	if body.name == "Player":
		body.end_game()
