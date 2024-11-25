extends CharacterBody3D

var RGBcontroller:CollisionShape3D
@export var i_ilumite:bool

@export var RGB:int
@export var destroyable:bool

@export var points_rout_export:Array[Node3D]

@export var speed:float
@export var margen_lerp:float

var len_points:int
var number_of_point:int = 0

var trigger:Area3D
var target
var contact_player:bool
var first_contact_player:bool

func _ready() -> void:
	RGBcontroller = $collision_RGB
	RGBcontroller.RGB = RGB
	RGBcontroller.destroyable = destroyable
	RGBcontroller.connect("Iilumite", Callable(self, "iluminate"))
	len_points = points_rout_export.size()
		
	trigger = $Trigger
	trigger.connect("body_entered", Callable(self, "_on_body_entered"))
	trigger.connect("body_exited", Callable(self, "_on_body_exited"))
	
func _process(delta: float) -> void:
	if !contact_player:
		route()
	else:
		move_to_player()
	
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
	
func route() -> void:
	if len_points == 0:
		return
	if !i_ilumite:
		move_to_route(points_rout_export[number_of_point].global_transform.origin)
	if number_of_point >= len_points:
		number_of_point = 0
		
func move_to_route(point) -> void:
	global_transform.origin = global_transform.origin.lerp(point, speed)
	look_at(point, Vector3.UP)
	rotation.y += deg_to_rad(180)
	if global_transform.origin.distance_to(point) < margen_lerp:
		number_of_point += 1
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
