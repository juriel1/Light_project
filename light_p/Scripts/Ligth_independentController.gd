extends Area3D

var mesh_ligth:MeshInstance3D
var shader:ShaderMaterial

@export var light_state:bool
@export var color_val:int
# 1 - R
# 2 - G
# 3 - B

signal change_color

func _ready() -> void:
	mesh_ligth = get_node("Mesh_ligth")
	shader = mesh_ligth.material_override
	shader_controller()

func shader_controller() -> void:
	shader.set_shader_parameter("Color_palette",color_val)
	shader.set_shader_parameter("On_shader",light_state)
