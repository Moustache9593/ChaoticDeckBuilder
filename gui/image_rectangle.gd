@tool
extends ColorRect
@export var texture=preload("res://assets/textures/player.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	$MarginContainer/TextureRect.texture = texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Engine.is_editor_hint():
		$MarginContainer/TextureRect.texture = texture
		pass
