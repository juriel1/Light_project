extends Area3D

@export var type_shape:int
@export var shape_:Shape3D
@export var collision_shape:CollisionShape3D
var collision:CollisionShape3D

func _ready() -> void:
	self.connect("body_entered", Callable(self, "_on_body_entered"))
	collision = $CollisionShape3D
	if type_shape == 1:
		collision.shape = shape_
	elif type_shape == 2:
		collision.shape = collision_shape.shape
	else:
		pass
	
func _on_body_entered(body):
	if body.name == "Player":
		body.dead_to_check_point()
