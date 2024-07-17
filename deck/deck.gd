extends CenterContainer
@onready var card_holder = $CardHolder

func give_card(object):
	var card = card_holder.get_child(0)
	card_holder.remove_child(card)
	object.add_child(card)

# Called when the node enters the scene tree for the first time.
func _ready():
	ready()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	process(delta)

func ready():
	pass

func process(_delta):
	pass


