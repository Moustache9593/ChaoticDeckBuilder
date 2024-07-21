@tool
extends "res://deck/card.gd"
@export var shield = 5.0


func ready():
	text = "Gain shield: " + str(shield) + "\n"
	super()

