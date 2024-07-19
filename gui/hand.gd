extends ColorRect
@export var inputs :PackedStringArray= []
signal card_used
signal card_discarded
signal get_card
var card_currently_selected = 0
var card_just_used = false
var hand_size = 4



func draw_card():
	emit_signal("get_card",$HandHolder)

func drawn_card(card):
	pass

func unselect_cards():
	for card in $HandHolder.get_children():
		card.selected = false

func fill_hand():
	for i in range(hand_size):
		draw_card()

func _ready():
	fill_hand()
	select_card(card_currently_selected)


func get_chuck_hand_input():
	if Input.is_action_just_pressed("chuck_hand"):
		return true
	else:
		return false

func get_use_card_input():
	if Input.is_action_just_pressed("use_card"):
		return true
	else:
		return false

func get_left_card(card):
	var card_index = card.get_index()
	if card_index > 0:
		return $HandHolder.get_child(card_index-1)
	else:
		return null

func get_right_card(card):
	var card_index = card.get_index()
	if card_index < $HandHolder.get_child_count() - 1:
		return $HandHolder.get_child(card_index+1)
	else:
		return null

func use_card(card_index):
	if $HandHolder.get_child_count() >= card_index + 1:
		var card = $HandHolder.get_child(card_index)
		if card.is_in_group("discard"):
			var left_card = get_left_card(card)
			var right_card = get_right_card(card)
			# Discard card to left
			if (card.discard_directions == "left" or\
			 card.discard_directions == "both") and left_card!=null:
				discard_card(left_card)
			if (card.discard_directions == "right" or\
			card.discard_directions == "both") and right_card != null:
				discard_card(right_card)
		card_just_used = true
		$HandHolder.remove_child(card)
		emit_signal("card_used",card)
	elif $HandHolder.get_child_count() < 1:
		push_warning("Tried to use card when hand is empty.")
	elif $HandHolder.get_child_count() < card_index + 1:
		push_warning("Tried to use card that isn't in hand.")

func discard_card(card):
	$HandHolder.remove_child(card)
	emit_signal("card_discarded",card)


func get_card_select_input():
	var card1_select = Input.is_action_just_pressed("first_card")
	var card2_select = Input.is_action_just_pressed("second_card")
	var card3_select = Input.is_action_just_pressed("third_card")
	var card4_select = Input.is_action_just_pressed("fourth_card")
	if card1_select:
		return 0
	elif card2_select:
		return 1
	elif card3_select:
		return 2
	elif card4_select:
		return 3
	else:
		return -1

func select_card(card_selected):
	unselect_cards()
	if $HandHolder.get_child_count() <= card_selected:
		card_selected = $HandHolder.get_child_count() - 1
	if card_selected != -1 and \
	$HandHolder.get_child_count() >= card_selected + 1:
		for card_index in $HandHolder.get_child_count():
			var card = $HandHolder.get_child(card_index)
			if card_index == card_selected:
				card.selected = true
				card_currently_selected = card_index

func hand_is_empty():
	return $HandHolder.get_child_count() <= 0

func _physics_process(_delta):
	var card_selected = get_card_select_input()
	if card_currently_selected > $HandHolder.get_child_count() - 1 and \
	not hand_is_empty():
		card_currently_selected = $HandHolder.get_child_count() - 1
	if card_just_used:
		select_card(card_currently_selected)
	if card_selected != -1:
		select_card(card_selected)
	if get_use_card_input():
		use_card(card_currently_selected)
	if hand_is_empty():
		fill_hand()





