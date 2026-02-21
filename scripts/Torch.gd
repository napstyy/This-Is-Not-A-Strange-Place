extends RigidBody2D

var attached_to: CharacterBody2D = null
var attach_offset: Vector2 = Vector2.ZERO
var original_collision_layer: int = 0
var original_collision_mask: int = 0

@export var prefab_id := 8

func _ready() -> void:
	add_to_group("torch")
	original_collision_layer = collision_layer
	original_collision_mask = collision_mask

func _physics_process(delta: float) -> void:
	if attached_to:
		if not attached_to.is_inside_tree():
			_detach()
		else:
			global_position = attached_to.global_position + attach_offset
			linear_velocity = Vector2.ZERO

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
