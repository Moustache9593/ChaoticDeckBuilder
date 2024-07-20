extends CharacterBody2D
signal health_change
signal shield_change

var move_dir := Vector2.ZERO
var vector_to_mouse := Vector2.ZERO
@export var max_health = 50
@onready var health = 0:
	set(value):
		health = value
		emit_signal("health_change",health)

var shield = 0:
	set(value):
		shield = value
		emit_signal("shield_change",shield)

@export var speed :float= 75.0
@export var dash_speed :float= 500.0

func get_mouse_vector():
	vector_to_mouse = get_global_mouse_position() - position 


func get_input():
	get_move_dir()
	get_mouse_vector()
	if Input.is_action_just_pressed("chuck_hand"):
		dash()

func get_move_dir():
	var move_x = float(Input.is_action_pressed("move_right")) - \
		float(Input.is_action_pressed("move_left"))
	var move_y = float(Input.is_action_pressed("move_down")) - \
		float(Input.is_action_pressed("move_up"))
	move_dir = Vector2(move_x,move_y).limit_length(1.0)
	return move_dir



func _ready():
	health = max_health


func take_damage(amount):
	shield -= amount
	if shield < 0:
		var health_lost = -shield
		health -= health_lost
		shield = 0

func gain_shield(amount):
	shield += amount

func dashing():
	return not $DashTimer.is_stopped()

func dash():
	$DashTimer.start()



func _physics_process(_delta):
	if not dashing():
		get_input()
		velocity = move_dir * speed
	else:
		velocity = move_dir * dash_speed
	move_and_slide()
	$Stick.rotation = vector_to_mouse.angle()


func _on_hit_box_area_entered(area):
	if area.is_in_group("enemy") and area.is_in_group("projectile"):
		take_damage(area.damage)
		area.queue_free()
