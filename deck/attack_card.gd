@tool
extends "res://deck/card.gd"
@export var damage = 5




func ready():
	text = "Damage: " + str(damage) + "\n"
	super()

