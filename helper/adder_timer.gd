
extends Timer
var ammount_to_add = 0
signal action_timer_timeout

func _on_timeout():
	emit_signal("action_timer_timeout",self)
	pass # Replace with function body.
