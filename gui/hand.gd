extends ColorRect
@export var inputs :PackedStringArray= []
signal card_used
signal card_discarded
signal give_card
signal get_card
signal mana_changed
signal chucked_card
var card_currently_selected = 0
var card_just_used = false
var hand_size = 5
@onready var hand_holder = $HBoxContainer/HandHolder
@onready var card_hold_right = $HBoxContainer/CardHoldRight
@onready var card_hold_left = $HBoxContainer/CardHoldLeft
var mana_holder = self
@export var max_mana = 5
var mana = max_mana:
	set(value):
		mana = value
		emit_signal("mana_changed",mana)






func draw_card():
	emit_signal("get_card",hand_holder)

func drawn_card(card):
	pass

func unselect_cards():
	for card in hand_holder.get_children():
		card.selected = false

func fill_hand():
	for i in range(hand_size):
		draw_card()
	mana = max_mana

func _ready():
	mana=max_mana
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

func get_hold_right_input():
	if Input.is_action_just_pressed("hold_right"):
		return true
	else:
		return false

func get_hold_left_input():
	if Input.is_action_just_pressed("hold_left"):
		return true
	else:
		return false

func get_left_card(card):
	var card_index = card.get_index()
	if card_index > 0:
		return hand_holder.get_child(card_index-1)
	else:
		return null

func get_right_card(card):
	var card_index = card.get_index()
	if card_index < hand_holder.get_child_count() - 1:
		return hand_holder.get_child(card_index+1)
	else:
		return null



func chuck_hand():
	for card in hand_holder.get_children():
		chuck_card(card)
	fill_hand()
	


func try_get_card(card_index, card):
	if hand_holder.get_child_count() >= card_index + 1:
		card.append(hand_holder.get_child(card_index))
		return true 
	else:
		return false




func use_card(card_index):
	var card = []
	if try_get_card(card_index,card) and card[0].mana_cost <= mana:
		card = card[0]
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
		mana -= card.mana_cost
		hand_holder.remove_child(card)
		emit_signal("card_used",card)
	elif try_get_card(card_index,card) and card[0].mana_cost > mana:
		$ManaErrorSoundEffect.play()
	elif hand_holder.get_child_count() < 1:
		push_warning("Tried to use card when hand is empty.")
	elif hand_holder.get_child_count() < card_index + 1:
		push_warning("Tried to use card that isn't in hand.")

func chuck_card(card):
	hand_holder.remove_child(card)
	emit_signal("chucked_card",card)

func discard_card(card):
	hand_holder.remove_child(card)
	emit_signal("card_discarded",card)

func hold_card_right(card):
	hand_holder.remove_child(card)
	card_hold_right.add_child(card)

func hold_card_left(card):
	hand_holder.remove_child(card)
	card_hold_left.add_child(card)

func get_card_select_input():
	var card1_select = Input.is_action_just_pressed("first_card")
	var card2_select = Input.is_action_just_pressed("second_card")
	var card3_select = Input.is_action_just_pressed("third_card")
	var card4_select = Input.is_action_just_pressed("fourth_card")
	var card5_select = Input.is_action_just_pressed("fifth_card")
	var card_right_select = Input.is_action_just_pressed("card_right")
	var card_left_select = Input.is_action_just_pressed("card_left")
	if card1_select:
		return 0
	elif card2_select:
		return 1
	elif card3_select:
		return 2
	elif card4_select:
		return 3
	elif card5_select:
		return 4
	elif card_right_select:
		return card_currently_selected + 1
	elif card_left_select:
		return card_currently_selected - 1
	else:
		return -1

func select_card(card_selected):
	unselect_cards()
	if hand_holder.get_child_count() <= card_selected:
		card_selected = hand_holder.get_child_count() - 1
	if card_selected != -1 and \
	hand_holder.get_child_count() >= card_selected + 1:
		for card_index in hand_holder.get_child_count():
			var card = hand_holder.get_child(card_index)
			if card_index == card_selected:
				card.selected = true
				card_currently_selected = card_index

func hand_is_empty():
	return hand_holder.get_child_count() <= 0


func get_currently_selected_card():
	return hand_holder.get_child(card_currently_selected)


func left_card_is_held():
	return card_hold_left.get_child_count() > 0

func right_card_is_held():
	return card_hold_right.get_child_count() > 0

func try_unhold_card(is_right):
	var card
	if is_right:
		card = card_hold_right.get_child(0)
	else:
		card = card_hold_left.get_child(0)
	if card.mana_cost <= mana:
		if is_right:
			card_hold_right.remove_child(card)
		else:
			card_hold_left.remove_child(card)
		hand_holder.add_child(card)
		if is_right:
			hand_holder.move_child(card,get_last_index())
		return true
	else:
		$ManaErrorSoundEffect.play()
		return false



func hand_full():
	return hand_holder.get_child_count() >= hand_size


func handle_card_selection():
	var card_selected = get_card_select_input()
	if card_currently_selected > hand_holder.get_child_count() - 1 and \
	not hand_is_empty():
		card_currently_selected = hand_holder.get_child_count() - 1
	if card_just_used:
		select_card(card_currently_selected)
	if card_selected != -1:
		select_card(card_selected)

func handle_card_hold():

	if get_hold_right_input():
		if not right_card_is_held():
			hold_card_right(get_currently_selected_card())
		elif right_card_is_held():
			if try_unhold_card(true):
				use_card(get_last_index())
	elif get_hold_left_input():
		if not left_card_is_held():
			hold_card_left(get_currently_selected_card())
		elif left_card_is_held():
			if try_unhold_card(false):
				use_card(get_first_index())

func _physics_process(_delta):
	if get_chuck_hand_input() and not chucking() and not filling_hand():
		$ChuckTimer.start()
	elif not chucking() and not filling_hand():
		handle_card_selection()
		handle_card_hold()
		if get_use_card_input():
			use_card(card_currently_selected)

func get_last_card():
	return hand_holder.get_child(hand_holder.get_child_count()-1)

func get_first_index():
	return 0

func get_last_index():
	return hand_holder.get_child_count()-1

func chucking():
	return not $ChuckTimer.is_stopped()


func filling_hand():
	return not $FillTimer.is_stopped()

func _on_chuck_timer_timeout():
	chuck_hand()



func _on_fill_timer_timeout():
	fill_hand()

