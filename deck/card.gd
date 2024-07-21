@tool
extends ColorRect
@export_multiline var text = "Card Placeholder"
@export var texture = preload("res://assets/textures/placeholder_texture.png")
@export var front_visible :bool = true
@export var title = "Card"
@export var mana_cost = 1
var mouse_in_card = false

var selected = true

func _ready():
	ready()
	

func ready():
	$MarginContainer/VSplitContainer/ImageRectangle.texture = texture
	$MarginContainer/VSplitContainer/TextRectangle.text = text
	$MarginContainer/CardBack.visible = not front_visible
	$MarginContainer/VSplitContainer/TitleRectangle.text = title
	$MarginContainer/VSplitContainer/ManaCostText.text = "Mana Cost: " + str(mana_cost)

func process(_delta):
	$MarginContainer/VSplitContainer/ImageRectangle.texture = texture
	$MarginContainer/VSplitContainer/TextRectangle.text = text
	$MarginContainer/CardBack.visible = not front_visible
	$MarginContainer/VSplitContainer/TitleRectangle.text = title
	$MarginContainer/VSplitContainer/ManaCostText.text  = "Mana Cost: " + str(mana_cost)
	if not selected:
		modulate = Color.hex(0xa7aeff)
	else:
		modulate = Color.WHITE



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process(delta)


func _on_mouse_entered():
	pass



func _on_mouse_exited():
	pass




func _on_color_rect_mouse_entered():
	mouse_in_card = true
	pass # Replace with function body.


func _on_color_rect_mouse_exited():
	mouse_in_card = false
	pass # Replace with function body.
