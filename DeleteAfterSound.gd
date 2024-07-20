extends AudioStreamPlayer



func _on_finished():
	queue_free()

func detach():
	var grandparent = get_parent().get_parent()
	get_parent().remove_child(self)
	grandparent.add_child(self)
	play()
