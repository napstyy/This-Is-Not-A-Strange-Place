
extends CharacterBody2D

@export var speed: float = 100.0
@export var min_pause: float = 0.5
@export var max_pause: float = 2.0
@export var min_walk: float = 1.0
@export var max_walk: float = 3.0
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D #for walking animation

@export var prefab_id := 6

@export var feet_area_path: NodePath = NodePath("FeetArea")

var direction: int = 0
var state: String = "idle"
var timer: float = 0.0

var is_held: bool = false

# snapping state
var attached_to: CharacterBody2D = null
var attached_offset: Vector2 = Vector2.ZERO

@onready var feet_area: Area2D = get_node_or_null(feet_area_path)

func _ready() -> void:
	randomize()
	pick_new_state()
	if feet_area:
		feet_area.body_entered.connect(_on_feet_body_entered)
		feet_area.body_exited.connect(_on_feet_body_exited)

func _physics_process(delta: float) -> void:
	# follow mouse when held (detaches if necessary)
	if is_held:
		if attached_to:
			_detach()
		global_position = get_global_mouse_position()
		velocity = Vector2.ZERO
		return

	# when attached, follow the attached body exactly
	if attached_to:
		if not attached_to.is_inside_tree():
			_detach()
		else:
			global_position = attached_to.global_position + attached_offset
			velocity = Vector2.ZERO
			return

	# gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta
	else:
		velocity.y = 0

	# AI timer
	timer -= delta
	if timer <= 0:
		pick_new_state()

	# horizontal movement
	if state == "walk":
		velocity.x = direction * speed
	else:
		velocity.x = 0

	# flip sprite if present
	if $Sprite2D:
		$Sprite2D.flip_h = direction < 0

	# move
	move_and_slide()

func _on_feet_body_entered(body: Node) -> void:
	# only snap to other CharacterBody2D, not self
	if attached_to:
		return
	if body == self:
		return
	if body is CharacterBody2D:
		# ensure the other body is below
		if body.global_position.y > global_position.y:
			attached_to = body
			attached_offset = global_position - attached_to.global_position
			state = "idle"
			velocity = Vector2.ZERO

func _on_feet_body_exited(body: Node) -> void:
	if attached_to == body:
		_detach()

# clicking on the NPC
func _input_event(viewport, event, shape_idx) -> void:
	print("hi")
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_held = true

# release anywhere
func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_held:
			is_held = false

func _detach() -> void:
	attached_to = null
	attached_offset = Vector2.ZERO

func pick_new_state() -> void:
	if randi() % 2 == 0:
		state = "walk"
		sprite_2d.play("walk")
		direction = [-1, 1].pick_random()
		timer = randf_range(min_walk, max_walk)
	else:
		state = "idle"
		sprite_2d.play("idle")
		timer = randf_range(min_pause, max_pause)
