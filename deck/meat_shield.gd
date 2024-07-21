@tool
extends "res://deck/card.gd"
@export var shield = 5.0
@export var self_damage = 30.0

func ready():
	text += "Gain Shield: " \
	+ str(shield) + "\n"
	text += "On Discard: Take " \
	+ str(self_damage) + " damage." + "\n"
	super()

