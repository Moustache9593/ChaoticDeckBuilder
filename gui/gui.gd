@tool
extends Control
signal card_used

# Called when the node enters the scene tree for the first time.
func _ready():
	set_deferred("size",get_window().size)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		size.x = ProjectSettings.get("display/window/size/viewport_width") 
		size.y = ProjectSettings.get("display/window/size/viewport_height")


func _input(event):
	if event is InputEventMouseMotion:
		if !Engine.is_editor_hint():
			$Crossairs.global_position = get_global_mouse_position()


func set_player_title(value):
	$VSplitContainer/HandRect/HBoxContainer/PlayerStatus/PlayerTitle.text =\
	value

func set_health_text(value):
	$VSplitContainer/HandRect/HBoxContainer/PlayerStatus/HealthText.text =\
	 "health: " + value

func set_shield_text(value):
	$VSplitContainer/HandRect/HBoxContainer/PlayerStatus/ShieldText.text =\
	 "shield: " + value




func _on_hand_card_used(card):
	emit_signal("card_used",card)
	pass # Replace with function body.





func _on_player_health_change(health):
	set_health_text(str(health))



func _on_player_shield_change(shield):
	set_shield_text(str(shield))
	pass # Replace with function body.
