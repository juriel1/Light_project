extends CanvasLayer

var origin_scale_viewport = 1078
var factor:float

@export var player:CharacterBody3D
@export var label:Label
@export var label_pause:Label

@export var control_splasher:Texture
@export var dead_panel:Texture
@export var check_panel:Texture
@export var treasure_panel:Texture

@export var center_sprite:Sprite2D

@export var origin_center_pos:Vector2
@export var down_pos:Vector2
@export var up_pos:Vector2
@export var speed_pos:float

@export var origin_scale:Vector2
@export var max_scale:Vector2
@export var min_scale:Vector2
@export var speed_scale:float
@export var splasher_scale:Vector2

var progress_lerp: float = 0.0

var type_funcion:int

func _ready() -> void:
	var window_size = DisplayServer.window_get_size()
	var viewport = get_viewport()
	factor = float(window_size.x)/origin_scale_viewport
	viewport.size = window_size
	
	origin_center_pos = Vector2(575*factor,325*factor)
	down_pos = Vector2(down_pos.x*factor,down_pos.y*factor)
	up_pos = Vector2(up_pos.x*factor,up_pos.y*factor)
	origin_scale = Vector2(origin_scale.x*factor,origin_scale.y*factor)
	max_scale = Vector2(max_scale.x*factor,max_scale.y*factor)
	min_scale = Vector2(min_scale.x*factor,min_scale.y*factor)
	splasher_scale = Vector2(splasher_scale.x*factor,splasher_scale.y*factor)
	
	player.connect("panel_canvas", Callable(self, "_on_my_signal_received"))
	on_pause()
	await get_tree().create_timer(3).timeout
	off_pause()
	
func _process(delta: float) -> void:
	if type_funcion==1:
		on_check(delta)
	elif type_funcion==2:
		on_dead(delta)
	elif type_funcion==3:
		on_treasure(delta)
	elif type_funcion==4:
		on_rampage(delta)
	else:
		pass
	

func _on_my_signal_received(message):
	if message == "check":
		type_funcion = 1
		progress_lerp = 0.0
		label.text = "Check Point"
	elif message == "dead":
		type_funcion = 2
		progress_lerp = 0.0
		label.text = "Dead"
	elif message == "treasure":
		type_funcion = 3
		progress_lerp = 0.0
		label.text = "Treasure"
	elif message == "rampage":
		type_funcion = 4
		progress_lerp = 0.0
		label.text = "Treasure"
	else:
		type_funcion = 0
		progress_lerp = 0.0

func on_check(delta):
	center_sprite.scale = origin_scale
	center_sprite.position = down_pos
	center_sprite.texture = check_panel
	if progress_lerp < 1.0:
		progress_lerp += speed_pos * delta
		center_sprite.position = down_pos.lerp(up_pos, progress_lerp)
	else:
		type_funcion = 0
		center_sprite.texture = null
		label.text = ""

func on_dead(delta):
	center_sprite.position = origin_center_pos
	center_sprite.scale = origin_scale
	center_sprite.position = up_pos
	center_sprite.texture = dead_panel
	if progress_lerp < 1.0:
		progress_lerp += speed_pos * delta
		center_sprite.position = up_pos.lerp(down_pos, progress_lerp)
	else:
		type_funcion = 0
		center_sprite.texture = null
		label.text = ""

func on_treasure(delta):
	center_sprite.position = origin_center_pos
	center_sprite.scale = min_scale
	center_sprite.texture = treasure_panel
	if progress_lerp < 1.0:
		progress_lerp += speed_scale * delta
		center_sprite.scale = min_scale.lerp(max_scale, progress_lerp)
	else:
		type_funcion = 0
		center_sprite.texture = null
		label.text = ""

func on_rampage(delta):
	if progress_lerp < 1.0:
		progress_lerp += speed_scale * delta
		label.text = "GO"
	else:
		type_funcion = 0
		center_sprite.texture = null
		label.text = ""

func on_pause():
	center_sprite.position = origin_center_pos
	center_sprite.texture = control_splasher
	center_sprite.scale = splasher_scale
	label.text = ""
	label_pause.visible = true
func off_pause():
	center_sprite.texture = null
	center_sprite.scale = origin_scale
	label.text = ""
	label_pause.visible = false
