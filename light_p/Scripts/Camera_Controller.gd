extends Camera3D

var player:CharacterBody3D
var ligth:MeshInstance3D

@export var mesh_cone:Mesh
@export var mesh_plane:Mesh

@export var change_type_camera:bool
@export var type_camera:bool
# True		== Fisrt Person
# False		==Third Person
@export var min_angle_Y:float = -20
@export var max_angle_Y:float = 85

var pivot_mesh_first
@export var scale_ligth_first:float
var pivot_mesh_third
@export var scale_ligth_third:float

var pivot_first
var pivot_third
var pivot_target


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player = get_parent()
	pivot_first = player.get_node("Fisrt_person_camera_pivot")
	pivot_third = player.get_node("Third_person_camera_pivot")
	
	pivot_mesh_first = player.get_node("Fisrt_person_ligth_pivot")
	pivot_mesh_third = player.get_node("Third_person_ligth_pivot")
	
	ligth = player.get_node("Ligth").get_node("Mesh_ligth")
	pivot_target = pivot_first
	ligth.mesh = mesh_plane
	ligth.global_transform.origin = pivot_mesh_first.global_transform.origin
	#ligth.global_transform.basis = pivot_mesh_first.global_transform.basis
	ligth.scale = Vector3(
		scale_ligth_first,
		scale_ligth_first,
		scale_ligth_first)


func _process(delta: float) -> void:
	pass
	#check_change_camera_mode()
	#move_towards_target()
		
func _input(event: InputEvent) -> void:	
	if event is InputEventMouseMotion:
		player.rotate_object_local(Vector3.UP, (event.relative.x * 0.001)*(-1))
		#FIRST PERSON CAMERA
		if type_camera:
			rotate_object_local(Vector3.RIGHT, (event.relative.y * 0.001)*(-1))	
			if (rotation.x *100) < min_angle_Y:
				rotation.x = min_angle_Y/100
			if (rotation.x *100) > max_angle_Y:
				rotation.x = max_angle_Y/100

func move_towards_target() -> void:
	if change_type_camera:
		# is first person
		if type_camera:
			pivot_target = pivot_first
			ligth.mesh = mesh_plane
			ligth.global_transform.origin = pivot_mesh_first.global_transform.origin
			ligth.scale = Vector3(
				scale_ligth_first,
				scale_ligth_first,
				scale_ligth_first)
		# is third person
		else:
			pivot_target = pivot_third
		# Move position
		global_transform.origin = global_transform.origin.lerp(pivot_target.global_transform.origin, 0.1)
		
		# Move rotation
		var current_rotation = global_transform.basis.get_rotation_quaternion()
		var target_rotation = pivot_target.global_transform.basis.get_rotation_quaternion()
		var interpolated_rotation = current_rotation.slerp(target_rotation, 0.1)
		global_transform.basis = Basis(interpolated_rotation)
		
		if global_transform.origin == pivot_target.global_transform.origin:
			change_type_camera = false
func check_change_camera_mode() -> void:
	if Input.is_action_just_pressed("C_camera_mode"):
		change_type_camera = true
		type_camera = !type_camera
