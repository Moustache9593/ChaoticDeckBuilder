@tool
extends "res://deck/card.gd"
@export var damage = 5
@export var speed = 800



func ready():
	text = "Damage: " + str(damage) + "\n"
	text += "Speed: " + str(speed)
	super()


func process(delta):
	text = "Damage: " + str(damage) + "\n" + \
	"Speed: " + str(speed)
	super(delta)
