extends RigidBody2D

var dragging := false

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.pressed:
			dragging = true
		else:
			dragging = false

func _physics_process(delta):
	if dragging:
		linear_velocity = Vector2.ZERO
		global_position = get_global_mouse_position()
