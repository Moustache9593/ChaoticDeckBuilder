extends CharacterBody2D

@export var projectile = preload("res://entities/projectile.tscn")

@export var max_health = 700.0

@onready var player = get_player()
var status_card = preload("res://deck/bomb_card.tscn")

var current_action = "invalid"

@onready var health = max_health:
	set(value):
		health = value
		$HealthBar.value = (health/max_health) * 100
		$HealthBar/HealthText.text = str(health)
		if health <= 0:
			call_deferred("queue_free")

func _ready():
	ready()
func _physics_process(delta):
	physics_process(delta)

const damage = 20
const projectile_speed = 900
func shoot_projectile(group):
	if player != null:
		var projectile_child = projectile.instantiate()
		projectile_child.damage = damage
		projectile_child.position = position
		var projectile_direction = player.position - position
		projectile_child.velocity = Vector2.RIGHT.rotated(projectile_direction.angle()) * projectile_speed
		add_sibling(projectile_child)
		projectile_child.add_to_group(group)
		projectile_child.scale *= 13


func get_player():
	return get_tree().get_first_node_in_group("player")

func ready():
	health = max_health
	choose_action()

func physics_process(delta):
	pass


func _on_projectile_timer_timeout():
	shoot_projectile("enemy")



func take_damage(amount):
	health -= amount
	if health != 0:
		$HurtSoundEffect.play()

func _on_hitbox_area_entered(area):
	if area.is_in_group("player") and area.is_in_group("projectile"):
		take_damage(area.damage)
		area.queue_free()

func get_player_deck():
	return get_tree().get_first_node_in_group("deck")

func _on_status_timer_timeout():
	var deck = get_player_deck()
	var bomb = status_card.instantiate()
	var discard_pile = deck.get_node("DiscardPile")
	discard_pile.add_child(bomb)

func choose_action():
	var random_percent = randf_range(0,100)
	if random_percent <= 50:
		current_action = "attack"
		$Marker2D/TextRectangle.text = "Attack for " + str(damage) + " damage."
	elif random_percent > 50:
		current_action = "status"
		$Marker2D/TextRectangle.text = "Inflicting status"
	


func _on_action_timer_timeout():
	match current_action:
		"attack":
			shoot_projectile("enemy")
		"status":
			_on_status_timer_timeout()
		_:
			push_error("Invalid enemy action!")
	choose_action()
	$EnemyActionSoundEffect.play()
