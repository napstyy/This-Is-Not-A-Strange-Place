extends Area2D

func _ready():
	# connect signals (remove if you already connected via editor)
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if not is_connected("body_exited", Callable(self, "_on_body_exited")):
		connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	# DEBUG: print who entered and what script/class it has
	print_debug("[Slot] body_entered:", body.name, " class:", body.get_class(), " script:", body.get_script())
	# call only if the body has the method (prevents the crash)
	if body.has_method("set_snap_target"):
		body.call("set_snap_target", global_position)
	else:
		push_warning("Entered body does not have set_snap_target(): " + str(body))

func _on_body_exited(body):
	print_debug("[Slot] body_exited:", body.name)
	if body.has_method("clear_snap_target"):
		body.call("clear_snap_target")
