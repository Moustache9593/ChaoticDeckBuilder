@tool
extends "res://deck/card.gd"
@export var self_damage = 5
@export var chuck_damage = 10


func ready():
	text = "Use: Take damage: " + str(self_damage) + "\n"
	text += "On Chuck: Take damage: " + str(chuck_damage)
	super()


func process(delta):
	text = "Take damage: " + str(self_damage) + "\n"
	text += "On Chuck: Take damage: " + str(chuck_damage)
	super(delta)
