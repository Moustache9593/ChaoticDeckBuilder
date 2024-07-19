extends "res://deck/card.gd"


@export var discard_directions = "left"

# Called when the node enters the scene tree for the first time.
func _ready():
	match discard_directions:
		"left":
			text = "Discard card to left"
		"right":
			text = "Discard card to right"
		"both":
			text = "Discard left and right cards"
		_:
			push_warning("Nonexistent direction " + str(discard_directions) + " given as discard_directions.")




