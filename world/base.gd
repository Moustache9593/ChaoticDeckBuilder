extends Node2D
@export var projectile := preload("res://entities/projectile.tscn")
@export var adder_timer_base := preload("res://helper/adder_timer.tscn")
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	player = $Player


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot_projectile(group, card):
	if $Enemy != null:
		$Enemy.take_damage(card.damage)
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
			pass
		"Heal":
			if player != null:
				player.heal(10)
		_:
			push_error("Invalid Card Title!")
	




func _on_gui_discarded_card(card):
	if card.title == "Dangerous Shield":
		if player != null:
			player.take_damage(card.self_damage)

	pass # Replace with function body.



func _on_gui_chucked_card(card):
	if card.title == "Bomb":
		if player != null:
			player.take_damage(card.chuck_damage)
	pass # Replace with function body.







