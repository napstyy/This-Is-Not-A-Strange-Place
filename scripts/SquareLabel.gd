extends RigidBody2D


@export var pick_radius := 48.0
@export var prefab_id := 0

var is_held := false
var is_snapped := false
var snap_target := Vector2.ZERO
var snap_area : Area2D = null

@onready var col_shape := $CollisionShape2D

func _ready():
	sleeping = false


func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_pick_up()


func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_held:
			return
		var mp = get_global_mouse_position()
		if mp.distance_to(global_position) <= pick_radius:
			_pick_up()


func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_held:
			_release()

func _physics_process(delta):
	if is_held:
		global_position = get_global_mouse_position()
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true
	elif is_snapped:
		global_position = snap_target
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true

func _pick_up():
	is_held = true
	sleeping = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	_clear_internal_snap()

func _release():
	is_held = false
	if is_snapped:
		global_position = snap_target
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true
	else:
		sleeping = false


func set_snap_target(center: Vector2, area = null) -> void:
	snap_target = center
	snap_area = area
	is_snapped = true
	if snap_area != null and snap_area.has_method("register_snapped_body"):
		snap_area.call("register_snapped_body", self)

func clear_snap_target() -> void:
	if snap_area != null and snap_area.has_method("unregister_snapped_body"):
		snap_area.call("unregister_snapped_body", self)
	_clear_internal_snap()

func _clear_internal_snap() -> void:
	is_snapped = false
	snap_target = Vector2.ZERO
	snap_area = null

func is_currently_held() -> bool:
	return is_held


func replace_with_scene(packed_scene: PackedScene) -> Node:
	if packed_scene == null:
		return null
	var new_node = packed_scene.instantiate()
	if new_node == null:
		return null
	var parent = get_parent()
	if parent == null:
		return null
	parent.add_child(new_node)
	if new_node is Node2D:
		new_node.global_position = global_position
	if is_snapped and snap_area != null:
		if new_node.has_method("set_snap_target"):
			new_node.call("set_snap_target", snap_target, snap_area)
		if snap_area.has_method("replace_snapped_body_reference"):
			snap_area.call("replace_snapped_body_reference", self, new_node)
	queue_free()
	return new_node

func get_prefab_id() -> int:
	return prefab_id
