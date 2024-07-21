extends Node
@export var discard_directions = "left"



# Called when the node enters the scene tree for the first time.
func _ready():
	var parent_ready_call = Callable(self,"add_to_text")
	get_parent().connect("ready",parent_ready_call)
	get_parent().add_to_group("discard_properties")



func add_to_text():
	match discard_directions:
		"left":
			get_parent().text += "Discard card to left" + "\n"
		"right":
			get_parent().text += "Discard card to right" + "\n"
		"both":
			get_parent().text += "Discard left and right cards" + "\n"
		_:
			push_warning("Nonexistent direction " + str(discard_directions) + " given as discard_directions.")
	get_parent().update_text()
