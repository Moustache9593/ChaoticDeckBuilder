@tool
extends Control
signal card_used
signal discarded_card
signal give_me_mana
signal chucked_card
func _ready():
	set_deferred("size",get_window().size)
	pass


func _process(_delta):
	if Engine.is_editor_hint():
		size.x = ProjectSettings.get("display/window/size/viewport_width") 
		size.y = ProjectSettings.get("display/window/size/viewport_height")


func _input(event):
	if event is InputEventMouseMotion:
		if !Engine.is_editor_hint():
			$Crossairs.global_position = get_global_mouse_position()


func set_player_title(value):
	$VSplitContainer/PlayerStatus/PlayerTitle.text =\
	value

func set_health_text(value):
	$VSplitContainer/PlayerStatus/HealthText.text =\
	 "Health: " + value

func set_shield_text(value):
	$VSplitContainer/PlayerStatus/ShieldText.text =\
	 "Shield: " + value

func set_mana_text(value):
	$VSplitContainer/PlayerStatus/ManaText.text =\
	 "Mana: " + str(value)


func _on_hand_card_used(card):
	emit_signal("card_used",card)
	$VSplitContainer/HandRect/HBoxContainer/Deck.add_to_discard_pile(card)






func _on_player_health_change(health):
	set_health_text(str(health))



func _on_player_shield_change(shield):
	set_shield_text(str(shield))



func _on_hand_card_discarded(card):
	emit_signal("discarded_card",card)
	$VSplitContainer/HandRect/HBoxContainer/Deck.add_to_discard_pile(card)
	







func _on_hand_mana_changed(mana):
	set_mana_text(mana)



func _on_hand_chucked_card(card):
	emit_signal("chucked_card",card)
	$VSplitContainer/HandRect/HBoxContainer/Deck.add_to_discard_pile(card)
