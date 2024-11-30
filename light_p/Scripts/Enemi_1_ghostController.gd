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

@export var invert_switch:bool

func _ready() -> void:
	RGBcontroller = $collision_RGB
	RGBcontroller.RGB = RGB
	RGBcontroller.destroyable = destroyable
	RGBcontroller.invert_switch = invert_switch
	RGBcontroller.connect("Iilumite", Callable(self, "iluminate"))
	len_points = points_rout_export.size()
	
	
func _process(delta: float) -> void:	
	route()
	
func route() -> void:
	if len_points == 0:
		return
	if !i_ilumite:
		move(points_rout_export[number_of_point].global_transform.origin)
	if number_of_point >= len_points:
		number_of_point = 0
		
func move(point) -> void:
	global_transform.origin = global_transform.origin.lerp(point, speed)
	if !position.is_equal_approx(point):
		var direction = point - position
		if direction.cross(Vector3.UP).is_zero_approx():
			pass
		else:
			look_at(point, Vector3.UP)
			rotation.y += deg_to_rad(180)
	if global_transform.origin.distance_to(point) < margen_lerp:
		number_of_point += 1
	
func iluminate(message) -> void:
	i_ilumite = message
