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
	$ShootEffect.play()


func get_mouse_vector():
	return get_global_mouse_position() - position 






func _on_gui_card_used(card):
	match card.title:
		"Shoot":
			if player != null:
				shoot_projectile("player",card)
		"Bomb":
			if player != null:
				player.take_damage(card.self_damage)
		"Shield":
			if player != null:
				player.gain_shield(card.shield)
		"Dangerous Shield":
			if player != null:
				player.gain_shield(card.shield)
		"Discard Left":
			$DiscardEffect.play()
		"Discard Right":
			$DiscardEffect.play()
		"Discard Both":
			$DiscardEffect.play()
		"Dash":
			if player != null:
				player.dash()
		"Heal":
			if player != null:
				player.heal(15)
		_:
			push_error("Invalid Card Title!")




func _on_gui_discarded_card(card):
	if card.title == "Dangerous Shield":
		if player != null:
			player.take_damage(card.self_damage)
	pass # Replace with function body.
