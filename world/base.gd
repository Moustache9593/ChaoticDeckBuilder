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
	if "speed" in card:
		projectile_child.speed = card.speed
	projectile_child.damage = card.damage
	projectile_child.position = player.position
	add_child(projectile_child)
	move_child(projectile_child, 0)
	projectile_child.add_to_group(group)


func _on_gui_card_used(card):
	if "damage" in card:
		shoot_projectile("player_projectile",card)
	if "self_damage" in card:
		player.take_damage(card.self_damage)
	if "shield" in card:
		player.gain_shield(card.shield)

