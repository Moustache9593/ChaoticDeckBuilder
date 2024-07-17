@tool
extends "res://deck/card.gd"
@export var self_damage = 5


func ready():
	text = "Take damage: " + str(self_damage) + "\n"
	super()


func process(delta):
	text = "Take damage: " + str(self_damage) + "\n"
	super(delta)
