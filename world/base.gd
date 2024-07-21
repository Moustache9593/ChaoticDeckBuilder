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
	for group in card.get_groups():
		match group:
			"meat_shield":
				player.gain_shield(card.shield)
				pass
			"exile_attack":
				if $Enemy != null:
					$Enemy.take_damage(card.damage)
			"attack_card":
				if $Enemy != null:
					$Enemy.take_damage(card.damage)
			"bomb":
				player.take_damage(card.self_damage)
				$BombSoundEffect.play()
			_:
				push_error("Invalid Card group: " + str(group) + "!")





func _on_gui_discarded_card(card):
	for group in card.get_groups():
		match group:
			"meat_shield":
				if player != null:
					player.take_damage(card.self_damage)





func _on_gui_chucked_card(card):
	for group in card.get_groups():
		match group:
			"bomb":
				player.take_damage(card.chuck_damage)
				$BombSoundEffect.play()








