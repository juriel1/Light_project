extends CollisionShape3D

signal Iilumite

@export var RGB:int
@export var destroyable:bool

var mesh:MeshInstance3D
var dead_zone:Area3D
var dead_zone_mesh:CollisionShape3D

var origin_scale_mesh:Vector3
var origin_scale_collision:Vector3
var origin_scale_dead_zone:Vector3
var origin_scale_dead_zone_mesh:Vector3

const FLT_MIN_SCALE = Vector3(1.0e-10,1.0e-10,1.0e-10)

@export var invert_switch:bool
var is_enemi:bool

func _ready() -> void:
	mesh = get_parent().get_node("MeshInstance3D")
	if get_parent().has_node("dead_zone"):
		dead_zone = get_parent().get_node("dead_zone")
		dead_zone_mesh = dead_zone.get_node("CollisionShape3D")
		origin_scale_dead_zone = dead_zone.scale
		origin_scale_dead_zone_mesh = dead_zone_mesh.scale
		is_enemi = true
	origin_scale_mesh = mesh.scale
	origin_scale_collision = scale


func get_rgb() -> int:
	return RGB

func IOff():
	if invert_switch:
		mesh.scale = origin_scale_mesh
		scale = origin_scale_collision
		if is_enemi:
			dead_zone.scale = origin_scale_dead_zone
			dead_zone_mesh.scale = origin_scale_dead_zone_mesh
		emit_signal("Iilumite",false)
		return
	mesh.scale = FLT_MIN_SCALE
	scale = FLT_MIN_SCALE
	if is_enemi:
		dead_zone.scale = FLT_MIN_SCALE
		dead_zone_mesh.scale = FLT_MIN_SCALE
	if destroyable:
		get_parent().queue_free()
	else:
		emit_signal("Iilumite",true)

func IOn():
	if invert_switch:
		mesh.scale = FLT_MIN_SCALE
		scale = FLT_MIN_SCALE
		if is_enemi:
			dead_zone.scale = FLT_MIN_SCALE
			dead_zone_mesh.scale = FLT_MIN_SCALE
		if destroyable:
			get_parent().queue_free()
		else:
			emit_signal("Iilumite",true)
		return
	mesh.scale = origin_scale_mesh
	scale = origin_scale_collision
	if is_enemi:
		dead_zone.scale = origin_scale_dead_zone
		dead_zone_mesh.scale = origin_scale_dead_zone_mesh
	emit_signal("Iilumite",false)
