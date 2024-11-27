extends Area3D

@export var points_move:Array[Node3D]
@export var platform:CharacterBody3D
@export var speed:float
@export var margen_lerp:float
@export var on:bool

var len_points:int
var number_of_point:int = 0

var area
var contact:bool


func _ready() -> void:
	len_points = points_move.size()
	area = $AreaCollision
	
	area.connect("area_entered", Callable(self, "_on_body_entered"))
	area.connect("area_exited", Callable(self, "_on_body_exited"))


func _process(delta: float) -> void:
	route()
	
func _on_body_entered(body):
	if body.name == "Player_trigger":
		contact = true
		
func _on_body_exited(body):
	if body.name == "Player_trigger":
		contact = false
		
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("action") and contact:
		print("CONTACT PLATFORM")
		on = !on

func route() -> void:
	if len_points == 0:
		return
	if on:
		move(points_move[number_of_point])
	if number_of_point >= len_points:
		number_of_point = 0
		
func move(point) -> void:
	platform.global_transform.origin = platform.global_transform.origin.lerp(point.global_transform.origin, speed)
	if platform.global_transform.origin.distance_to(point.global_transform.origin) < margen_lerp:
		number_of_point += 1
