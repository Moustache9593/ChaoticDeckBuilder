@tool
extends "res://deck/card.gd"
@export var shield = 5.0
@export var self_damage = 10.0
func ready():
	text = "Gain shield: " + str(shield) + "\n"
	text += "On discard: take " + str(self_damage) + " damage.\n"
	super()


