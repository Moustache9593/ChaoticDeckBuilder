extends CharacterBody2D

@export var max_health = 110
@onready var health = max_health:
	set(value):
		health = value
		if health < 0:
			call_deferred("queue_free")

func _ready():
	ready()
func _physics_process(delta):
	physics_process(delta)

func ready():
	pass
func physics_process(delta):
	pass
