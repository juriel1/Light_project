extends Area3D

@export var door:CharacterBody3D

@export var pos_rot_1:Node3D
@export var pos_rot_2:Node3D

@export var speed:float
@export var margen_lerp:float
@export var open:bool
var on:bool

@export var type_rot_or_pos:bool

var area
var contact:bool


func _ready() -> void:
	area = $AreaCollision
	
	area.connect("area_entered", Callable(self, "_on_body_entered"))
	area.connect("area_exited", Callable(self, "_on_body_exited"))
	
func _on_body_entered(body):
	if body.name == "Player_trigger":
		contact = true
		
func _on_body_exited(body):
	if body.name == "Player_trigger":
		contact = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and contact:
		open = !open
		on = true

func _process(delta: float) -> void:
	if on:
		if type_rot_or_pos == true:
			if open:
				rotation(pos_rot_1)
			else:
				rotation(pos_rot_2)
		else:
			if open:
				move(pos_rot_1)
			else:
				move(pos_rot_2)
	
func move(point):
	door.global_transform.origin = door.global_transform.origin.lerp(point.global_transform.origin, speed)
	if door.global_transform.origin.distance_to(point.global_transform.origin) < margen_lerp:
		on = false
func rotation(point):
	var target_rotation = Quaternion(point.global_transform.basis)
	door.global_transform.basis = Basis(Quaternion(door.global_transform.basis).slerp(target_rotation, speed))
	if door.global_transform.origin.distance_to(point.global_transform.origin) < margen_lerp:
		on = false
