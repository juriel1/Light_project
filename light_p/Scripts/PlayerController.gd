extends CharacterBody3D

@export var speed:float = 5.0
@export var jump_force:float = 4.5

@export var check_point:Area3D

var treasures_count:int
@export var max_treaure_in_scene:int
@export var enemy_rampage : Array[CharacterBody3D]
@export var enemy_rampage_pos : Array[Vector3]
var invoke_treasure:bool

signal panel_canvas

func _ready() -> void:
	save_pos_rampage()

func _process(delta: float) -> void:
	check_treasure()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_force

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := ((transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized())*(-1)
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	move_and_slide()
	
func get_new_check_point(point:Area3D):
	if check_point != point:
		check_point = point
		print("new check point ", check_point.name)
		emit_signal("panel_canvas","check")
func dead_to_check_point():
	global_transform.origin = check_point.global_transform.origin
	emit_signal("panel_canvas","dead")
func up_treasure():
	treasures_count +=1
	print("up treaure")
	emit_signal("panel_canvas","treasure")

func check_treasure():
	if treasures_count >= max_treaure_in_scene and !invoke_treasure: 
		for i in range(len(enemy_rampage)):
			enemy_rampage[i].global_transform.origin = enemy_rampage_pos[i]
		invoke_treasure = true
		emit_signal("panel_canvas","rampage")
func save_pos_rampage():
	for i in range(len(enemy_rampage)):
			enemy_rampage_pos[i] = enemy_rampage[i].global_transform.origin
			enemy_rampage[i].global_transform.origin = Vector3(150,150,150)
			
func end_game():
	if treasures_count >= max_treaure_in_scene:
		print("END GAME")
