extends CharacterBody3D

@export var speed:float = 5.0
@export var jump_force:float = 4.5

@export var check_point:Area3D

var treasures_count:int


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
	check_point = point
	print("new check point ", check_point.name)
func dead_to_check_point():
	global_transform.origin = check_point.global_transform.origin
func up_treasure():
	treasures_count +=1
