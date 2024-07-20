extends Control



func add_cards_to_deck():
	var deck = get_tree().get_first_node_in_group("deck")
	for card in get_children():
		var new_card = card.duplicate()
		var active_deck = deck.get_node("ActiveDeck")
		active_deck.add_child(new_card)

