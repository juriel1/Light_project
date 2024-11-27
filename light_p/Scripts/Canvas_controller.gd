extends CanvasLayer

@export var player:CharacterBody3D
@export var label:Label

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

var progress_lerp: float = 0.0

var type_funcion:int

func _ready() -> void:
	origin_center_pos = Vector2(575,325)
	player.connect("panel_canvas", Callable(self, "_on_my_signal_received"))
	
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
	print(progress_lerp)
	center_sprite.position = origin_center_pos
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
	print(progress_lerp)
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
	print(progress_lerp)
	center_sprite.position = origin_center_pos
	center_sprite.scale = origin_scale
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
	else:
		type_funcion = 0
		center_sprite.texture = null
		label.text = ""
	
