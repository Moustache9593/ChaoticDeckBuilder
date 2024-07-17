extends CharacterBody2D

var move_dir := Vector2.ZERO
var vector_to_mouse := Vector2.ZERO
@export var speed := 500.0

func get_mouse_vector():
	vector_to_mouse = get_global_mouse_position() - position 


func get_input():
	get_move_dir()
	get_mouse_vector()

func get_move_dir():
	var move_x = float(Input.is_action_pressed("move_right")) - \
		float(Input.is_action_pressed("move_left"))
	var move_y = float(Input.is_action_pressed("move_down")) - \
		float(Input.is_action_pressed("move_up"))
	move_dir = Vector2(move_x,move_y).limit_length(1.0)
	return move_dir

func _physics_process(_delta):
	get_input()
	velocity = move_dir * speed
	move_and_slide()
	$Stick.rotation = vector_to_mouse.angle()
