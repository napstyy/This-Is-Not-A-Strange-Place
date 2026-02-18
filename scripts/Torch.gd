extends RigidBody2D

var dragging: bool = false
var attached_to: CharacterBody2D = null
var attach_offset: Vector2 = Vector2.ZERO
var original_collision_layer: int = 0
var original_collision_mask: int = 0

@onready var attach_area: Area2D = $AttachArea

func _ready() -> void:
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask
	if attach_area:
		attach_area.monitoring = true
		attach_area.input_pickable = true
		attach_area.connect("input_event", Callable(self, "_on_attach_area_input"))

func _on_attach_area_input(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if attached_to:
				_detach()
			dragging = true
		else:
			dragging = false
			_try_attach_on_drop()

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			if attached_to:
				_detach()
			dragging = true
		else:
			dragging = false
			_try_attach_on_drop()

func _physics_process(delta: float) -> void:
	if dragging:
		linear_velocity = Vector2.ZERO
		global_position = get_global_mouse_position()
		return
	if attached_to:
		if not attached_to.is_inside_tree():
			_detach()
		else:
			global_position = attached_to.global_position + attach_offset
			linear_velocity = Vector2.ZERO
			return

func _try_attach_on_drop() -> void:
	if not attach_area or attached_to:
		return
	for body in attach_area.get_overlapping_bodies():
		if body == self:
			continue
		if body is CharacterBody2D:
			_attach_to(body)
			return

func _attach_to(body: CharacterBody2D) -> void:
	attached_to = body
	attach_offset = global_position - attached_to.global_position
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask
	collision_layer = 0
	collision_mask = 0
	linear_velocity = Vector2.ZERO
	angular_velocity = 0.0

func _detach() -> void:
	if not attached_to:
		return
	collision_layer = original_collision_layer
	collision_mask = original_collision_mask
	attached_to = null
