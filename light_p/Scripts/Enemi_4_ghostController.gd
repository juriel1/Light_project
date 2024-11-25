extends CharacterBody3D

var RGBcontroller:CollisionShape3D
@export var i_ilumite:bool

@export var RGB:int
@export var destroyable:bool

@export var speed:float
@export var margen_lerp:float

var trigger:Area3D
var target
var contact_player:bool
var first_contact_player:bool

func _ready() -> void:
	RGBcontroller = $collision_RGB
	RGBcontroller.RGB = RGB
	RGBcontroller.destroyable = destroyable
	RGBcontroller.connect("Iilumite", Callable(self, "iluminate"))
	
	trigger = $Trigger
	trigger.connect("body_entered", Callable(self, "_on_body_entered"))
	trigger.connect("body_exited", Callable(self, "_on_body_exited"))


func _process(delta: float) -> void:
	pass
	
func _on_body_entered(body):
	if !first_contact_player:
		if body.name == "Player":
			target = body
			first_contact_player = true
			contact_player = true
	else:
		if body.name == "Player":
			contact_player = true
			

func _on_body_exited(body):
	contact_player = false
	
func move_to_player() -> void:
	if !i_ilumite:
		global_transform.origin = global_transform.origin.lerp(
			target.global_transform.origin, speed
			)
		look_at(target.global_transform.origin, Vector3.UP)
		rotation.y += deg_to_rad(180)

func iluminate(message) -> void:
	i_ilumite = message
	#contact_player = false
