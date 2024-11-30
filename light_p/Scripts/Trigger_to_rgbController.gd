extends CollisionShape3D
var area
var bodies_in_side = []

func _ready() -> void:
	area = get_parent()
	area.connect("body_entered", Callable(self, "_on_body_entered"))
	area.connect("body_exited", Callable(self, "_on_body_exited"))
	area.connect("change_color", Callable(self, "_on_my_signal_received"))
	area.connect("innit", Callable(self, "_on_my_signal_received"))

func _on_body_entered(body):
	if body.has_node("collision_RGB"):
		var body_rgb = body.get_node("collision_RGB")
		bodies_in_side.append(body_rgb)
		if area.color_val == body_rgb.RGB and area.light_state:
			body_rgb.IOff()

func _on_body_exited(body):
	if body.has_node("collision_RGB"):
		var body_rgb = body.get_node("collision_RGB")
		bodies_in_side.erase(body_rgb)
		body_rgb.IOn()

func _on_my_signal_received(message):
	for body in bodies_in_side:
		if area.color_val == body.RGB  and area.light_state:
			body.IOff()
		else:
			body.IOn()
			
