extends CharacterBody2D

@export var prefab_id := 6
@onready var sprite_2d: AnimatedSprite2D = $AnimSprite2D
@onready var animation_player: AnimationPlayer = $AnimSprite2D/AnimationPlayer

var is_held: bool = false
var attached_to: CharacterBody2D = null
var attached_offset: Vector2 = Vector2.ZERO

@export var feet_area_path: NodePath = NodePath("FeetArea")
@onready var feet_area: Area2D = get_node_or_null(feet_area_path)

func _ready() -> void:
	add_to_group("human")
	if sprite_2d and sprite_2d.get_sprite_frames().has_animation("idle"):
		sprite_2d.play("idle")
	
	if feet_area:
		feet_area.body_entered.connect(_on_feet_body_entered)
		feet_area.body_exited.connect(_on_feet_body_exited)

func _physics_process(delta: float) -> void:
	if is_held:
		if attached_to:
			_detach()
		global_position = get_global_mouse_position()
		velocity = Vector2.ZERO
		return

	if attached_to:
		if not attached_to.is_inside_tree():
			_detach()
		else:
			global_position = attached_to.global_position + attached_offset
			velocity = Vector2.ZERO
			return

	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0

	velocity.x = 0
	move_and_slide()

func _on_feet_body_entered(body: Node) -> void:
	if attached_to or body == self:
		return
	if body is CharacterBody2D:
		if body.global_position.y > global_position.y:
			attached_to = body
			attached_offset = global_position - attached_to.global_position
			velocity = Vector2.ZERO

func _on_feet_body_exited(body: Node) -> void:
	if attached_to == body:
		_detach()

func _input_event(viewport, event, shape_idx) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_held = true

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_held:
			is_held = false

func _detach() -> void:
	attached_to = null
	attached_offset = Vector2.ZERO

func play_anim(animname):
	animation_player.play(animname)

func stop_anim():
	animation_player.stop()
