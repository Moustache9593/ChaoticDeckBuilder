@tool
extends "res://deck/card.gd"
@export var damage = 5
@export var speed = 800.0



func ready():
	#text = "Damage: " + str(damage) + "\n"
	#text += "Speed: " + str(speed)
	#super()
	pass

func process(delta):
	text = "Damage: " + str(damage) + "\n" + \
	"Speed: " + str(speed)
	super(delta)
