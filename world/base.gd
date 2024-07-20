extends Node2D
@export var projectile := preload("res://entities/projectile.tscn")
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot_projectile(group, card):
	var projectile_child = projectile.instantiate()
	var speed = 600
	if "speed" in card:
			speed = card.speed
	projectile_child.damage = card.damage
	projectile_child.position = player.position
	var projectile_direction = get_mouse_vector() - player.position
	projectile_child.velocity = Vector2.RIGHT.rotated(projectile_direction.angle()) * speed
	add_child(projectile_child)
	move_child(projectile_child, 0)
	projectile_child.add_to_group(group)


func get_mouse_vector():
	return get_global_mouse_position() - position 


func _on_gui_card_used(card):
	if "damage" in card:
		shoot_projectile("player",card)
	if "self_damage" in card:
		player.take_damage(card.self_damage)
	if "shield" in card:
		player.gain_shield(card.shield)
	if card.is_in_group("discard"):
		pass
	if card.is_in_group("dash"):
		player.dash()

