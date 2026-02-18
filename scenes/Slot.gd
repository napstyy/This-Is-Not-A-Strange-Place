extends Area2D

func _ready():
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if not is_connected("body_exited", Callable(self, "_on_body_exited")):
		connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.has_method("set_snap_target") and body.has_method("is_currently_held") and body.call("is_currently_held"):
		body.call("set_snap_target", global_position)

func _on_body_exited(body):
	if body.has_method("clear_snap_target"):
		body.call("clear_snap_target")
