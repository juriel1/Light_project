extends CollisionShape3D

signal Iilumite

@export var RGB:int
@export var destroyable:bool

var mesh:MeshInstance3D

var origin_scale_mesh:Vector3
var origin_scale_collision:Vector3

const ZERO_SCALE = Vector3(0,0,0)
const FLT_MIN_SCALE = Vector3(1.0e-10,1.0e-10,1.0e-10)

@export var invert_switch:bool

func _ready() -> void:
	mesh = get_parent().get_node("MeshInstance3D")
	origin_scale_mesh = mesh.scale
	origin_scale_collision = scale

func get_rgb() -> int:
	return RGB

func IOff():
	if invert_switch:
		mesh.scale = origin_scale_mesh
		scale = origin_scale_collision
		emit_signal("Iilumite",false)
		return
	mesh.scale = ZERO_SCALE
	scale = FLT_MIN_SCALE
	if destroyable:
		get_parent().queue_free()
	else:
		emit_signal("Iilumite",true)

func IOn():
	if invert_switch:
		mesh.scale = ZERO_SCALE
		scale = FLT_MIN_SCALE
		if destroyable:
			get_parent().queue_free()
		else:
			emit_signal("Iilumite",true)
		return
	mesh.scale = origin_scale_mesh
	scale = origin_scale_collision
	emit_signal("Iilumite",false)
