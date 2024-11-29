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
	light_state = true
	color_val = 2

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("red_color"):
		color_val = 1
		emit_signal("change_color",1)
	if event.is_action_pressed("green_color"):
		color_val = 2
		emit_signal("change_color",2)
	if event.is_action_pressed("blue_color"):
		color_val = 3
		emit_signal("change_color",3)
		
	if event.is_action_pressed("on_ligth") and !light_state:
		light_state = true
		emit_signal("change_color",color_val)
	if event.is_action_pressed("off_ligth") and light_state:
		light_state = false
		emit_signal("change_color",4)
	
	shader_controller()

func shader_controller() -> void:
	shader.set_shader_parameter("Color_palette",color_val)
	shader.set_shader_parameter("On_shader",light_state)
