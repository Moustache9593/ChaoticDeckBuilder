extends ColorRect
@export var inputs :PackedStringArray= []
signal card_used
signal get_card
var card_currently_selected = 0
var card_just_used = false
var hand_size = 3

func draw_card():
	emit_signal("get_card",$HandHolder)


func _ready():
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

func use_card(card_index):
	if $HandHolder.get_child_count() >= card_index + 1:
		var card = $HandHolder.get_child(card_index)
		emit_signal("card_used",card)
		card_just_used = true
		card.queue_free()
	elif $HandHolder.get_child_count() < 1:
		push_warning("Tried to use card when hand is empty.")
	elif $HandHolder.get_child_count() < card_index + 1:
		push_warning("Tried to use card that isn't in hand.")

func get_card_select_input():
	var card1_select = Input.is_action_just_pressed("first_card")
	var card2_select = Input.is_action_just_pressed("second_card")
	var card3_select = Input.is_action_just_pressed("third_card")
	if card1_select:
		return 0
	elif card2_select:
		return 1
	elif card3_select:
		return 2
	else:
		return -1

func select_card(card_selected):
	if card_selected != -1 and \
	$HandHolder.get_child_count() >= card_selected + 1:
		for card_index in $HandHolder.get_child_count():
			var card = $HandHolder.get_child(card_index)
			if card_index == card_selected:
				card.selected = true
				card_currently_selected = card_index
			else:
				card.selected = false

func _physics_process(_delta):
	var card_selected = get_card_select_input()
	if card_currently_selected > $HandHolder.get_child_count() - 1 and \
	$HandHolder.get_child_count() >= 1:
		card_currently_selected = $HandHolder.get_child_count() - 1
	if card_just_used:
		select_card(card_currently_selected)
	select_card(card_selected)
	if get_use_card_input():
		use_card(card_currently_selected)
	if get_chuck_hand_input():
		chuck_hand()
	

func chuck_hand():
	for card in $HandHolder.get_children():
		$HandHolder.remove_child(card)
	for card_index in range(hand_size):
		draw_card()

