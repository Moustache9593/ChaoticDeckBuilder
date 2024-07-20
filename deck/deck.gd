extends CenterContainer
@onready var active_deck = $ActiveDeck
@onready var discard_pile = $DiscardPile


func active_deck_is_empty():
	return active_deck == null or active_deck.get_child_count() == 0

func add_discard_to_active_deck():
	for card in discard_pile.get_children():
		discard_pile.remove_child(card)
		active_deck.add_child(card)

func shuffle_deck():
	add_discard_to_active_deck()
	var shuffled_cards = active_deck.get_children()
	shuffled_cards.shuffle()
	for card in shuffled_cards:
		active_deck.move_child(card,0)


func give_card(object):
	# Shuffle deck if needed
	if active_deck_is_empty():
		shuffle_deck()
	if not active_deck_is_empty():
		var card = active_deck.get_child(0)
		active_deck.remove_child(card)
		object.add_child(card)
	else:
		push_warning("Active deck is empty and wasn't able to fill it.")

func add_to_discard_pile(card):
	$DiscardPile.add_child(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process(delta)

func ready():
	Library.add_cards_to_deck()
	shuffle_deck()

func process(_delta):
	pass


