extends CharacterBody2D
signal health_change
signal shield_change
signal mana_change

var move_dir := Vector2.ZERO
var vector_to_mouse := Vector2.ZERO
var dead = false
@export var max_health = 50
@onready var health = 0:
	set(value):
		health = value
		emit_signal("health_change",health)
		if health <= 0:
			die()



var shield = 0:
	set(value):
		shield = value
		emit_signal("shield_change",shield)

@export var speed :float= 75.0
@export var dash_speed :float= 500.0

func get_mouse_vector():
	vector_to_mouse = get_global_mouse_position() - position 


func get_input():
	get_move_dir()
	get_mouse_vector()


func get_move_dir():
	var move_x = float(Input.is_action_pressed("move_right")) - \
		float(Input.is_action_pressed("move_left"))
	var move_y = float(Input.is_action_pressed("move_down")) - \
		float(Input.is_action_pressed("move_up"))
	move_dir = Vector2(move_x,move_y).limit_length(1.0)
	return move_dir


func die():
	if not dead:
		#$DeathSoundEffect.detach()
		queue_free()
		dead = true
		get_tree().change_scene_to_file("res://world/game_over.tscn")


func _ready():
	health = max_health


func take_damage(amount):
	shield -= amount
	if shield < 0:
		var health_lost = -shield
		health -= health_lost
		shield = 0
	if health != 0:
		$HurtSoundEffect.play()

func lose_all_shield():
	shield = 0

func gain_shield(amount):
	shield += amount
	$ShieldUpEffect.play()

func heal(amount):
	health += amount
	if health > max_health:
		health = max_health
	$HealSoundEffect.play()

func dashing():
	return not $DashTimer.is_stopped()

func dash():
	$DashTimer.start()
	$DashSoundEffect.play()




func _on_hit_box_area_entered(area):
	if area.is_in_group("enemy") and area.is_in_group("projectile"):
		take_damage(area.damage)
		area.queue_free()
