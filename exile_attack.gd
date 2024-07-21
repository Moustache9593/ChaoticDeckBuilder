@tool
extends "res://deck/card.gd"
@export var damage = 5




func ready():
	super()
	$MarginContainer/VSplitContainer/TextRectangle.text += "Damage: " + str(damage)
