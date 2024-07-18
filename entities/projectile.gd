extends Area2D
var move_dir := Vector2.ZERO
var vector_to_mouse := Vector2.ZERO
var speed := 500.0
var velocity = Vector2.RIGHT * speed
var damage = 5
func get_mouse_vector():
	vector_to_mouse = get_global_mouse_position() - position 

func _ready():
	get_mouse_vector()
	move_dir = vector_to_mouse.limit_length(1)
	velocity = move_dir * speed

func _physics_process(delta):
	position += velocity * delta



func _on_body_entered(body):
	if body.is_in_group("enemy") and is_in_group("player_projectile"):
		body.health -= damage
		queue_free()
	elif body.is_in_group("player") and is_in_group("enemy_projectile"):
		body.health -= damage
		queue_free()

