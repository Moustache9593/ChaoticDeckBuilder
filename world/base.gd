extends Node2D
@export var projectile := preload("res://entities/projectile.tscn")
@onready var player = $Player
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_gui_card_used(card):
	if "damage" in card:
		var projectile_child = projectile.instantiate()
		if "speed" in card:
			projectile_child.speed = card.speed
		projectile_child.damage = card.damage
		projectile_child.position = $Player.position
		add_child(projectile_child)
		move_child(projectile_child, 0)
	if "self_damage" in card:
		player.take_damage(card.self_damage)
	if "shield" in card:
		player.gain_shield(card.shield)

