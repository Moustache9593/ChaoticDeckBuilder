@tool
extends ColorRect
@export_multiline var text = "Card Placeholder"
@export var texture = preload("res://assets/textures/placeholder_texture.png")
@export var front_visible :bool = true
var selected = true

func _ready():
	ready()
	

func ready():
	$MarginContainer/VSplitContainer/ImageRectangle.texture = texture
	$MarginContainer/VSplitContainer/TextRectangle.text = text
	$MarginContainer/CardBack.visible = not front_visible

func process(_delta):
	$MarginContainer/VSplitContainer/ImageRectangle.texture = texture
	$MarginContainer/VSplitContainer/TextRectangle.text = text
	$MarginContainer/CardBack.visible = not front_visible
	if not selected:
		modulate = Color.hex(0xa7aeff)
		pass
	else:
		modulate = Color.WHITE
		pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process(delta)
