extends Area2D
var velocity = Vector2.RIGHT
var damage = 5

func _physics_process(delta):
	position += velocity * delta



