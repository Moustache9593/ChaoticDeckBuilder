@tool
extends ColorRect
var text = ""
@export_multiline var explanation = "Card Placeholder"
@export var texture = preload("res://assets/textures/placeholder_texture.png")
@export var front_visible :bool = true
@export var mana_cost = 1
@export var title = "Card"
var mouse_in_card = false

var selected = true

func _ready():
	ready()
	

func ready():
	$MarginContainer/VSplitContainer/ImageRectangle.texture = texture
	$MarginContainer/CardBack.visible = not front_visible
	update_text()



func update_text():
	$MarginContainer/VSplitContainer/TextRectangle.text = text + "\n" + explanation + "\n"
	$MarginContainer/VSplitContainer/ManaCostText.text = "Mana Cost: " + str(mana_cost)
	$MarginContainer/VSplitContainer/TitleRectangle.text = title


func process(_delta):
	if selected:
		modulate = Color(1,1,1,1)
	else:
		modulate = Color(.5,.5,.5,1)
	pass



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
