extends CharacterBody2D

@export var projectile = preload("res://entities/projectile.tscn")

@export var max_health = 110

@onready var player = get_player()

@onready var health = max_health:
	set(value):
		health = value
		if health < 0:
			call_deferred("queue_free")

func _ready():
	ready()
func _physics_process(delta):
	physics_process(delta)

const damage = 10
const projectile_speed = 650
func shoot_projectile(group):
	var projectile_child = projectile.instantiate()
	projectile_child.damage = damage
	projectile_child.position = position
	var projectile_direction = player.position - position
	projectile_child.velocity = Vector2.RIGHT.rotated(projectile_direction.angle()) * projectile_speed
	add_sibling(projectile_child)
	projectile_child.add_to_group(group)
	projectile_child.scale *= 14


func get_player():
	return get_tree().get_first_node_in_group("player")

func ready():
	pass
func physics_process(delta):
	pass


func _on_projectile_timer_timeout():
	shoot_projectile("enemy")



func take_damage(amount):
	health -= amount

func _on_hitbox_area_entered(area):
	if area.is_in_group("player") and area.is_in_group("projectile"):
		take_damage(area.damage)

