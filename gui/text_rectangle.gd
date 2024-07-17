@tool
extends ColorRect


@export_multiline var text = "Text Placeholder":
	set(value):
		text = value
		if is_ready:
			$MarginContainer/ColorRect/Label.text = text
var is_ready = false


# Called when the node enters the scene tree for the first time.
func _ready():
	is_ready = true
	text = text
	



