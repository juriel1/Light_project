extends CharacterBody3D

var RGBcontroller:CollisionShape3D

@export var RGB:int
@export var destroyable:bool

@export var points_rout_export:Array[Node3D]

@export var speed:float
@export var margen_lerp:float

var len_points:int
var number_of_point:int = 0

func _ready() -> void:
	RGBcontroller = $collision_RGB
	RGBcontroller.RGB = RGB
	RGBcontroller.destroyable = destroyable
	RGBcontroller.connect("Iilumite", Callable(self, "iluminate"))
	len_points = points_rout_export.size()
	
func _process(delta: float) -> void:	
	route()
	
func route() -> void:
	if len_points == 0:
		return
	move(points_rout_export[number_of_point].global_transform.origin)
	if number_of_point >= len_points:
		number_of_point = 0
		
func move(point) -> void:
	global_transform.origin = global_transform.origin.lerp(point, speed)
	look_at(point, Vector3.UP)
	rotation.y += deg_to_rad(180)
	if global_transform.origin.distance_to(point) < margen_lerp:
		number_of_point += 1
	
