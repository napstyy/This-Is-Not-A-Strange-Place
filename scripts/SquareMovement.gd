extends CharacterBody2D

@export var speed := 100
@export var min_pause := 0.5
@export var max_pause := 2.0
@export var min_walk := 1.0
@export var max_walk := 3.0

var direction := 0
var state := "idle"
var timer := 0.0

var is_held := false
var snap_target = null  # you can remove this line entirely if you want

func _ready():
	randomize()
	pick_new_state()

func _physics_process(delta):
	if is_held:
		global_position = get_global_mouse_position()
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

	# flip sprite
	if direction != 0 and $Sprite2D:
		$Sprite2D.flip_h = direction < 0

	# apply movement
	move_and_slide()

func pick_new_state():
	if randi() % 2 == 0:
		state = "walk"
		direction = [-1, 1].pick_random()
		timer = randf_range(min_walk, max_walk)
	else:
		state = "idle"
		timer = randf_range(min_pause, max_pause)

# clicking on the NPC (CollisionShape2D must have "Input Pickable" enabled)
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		is_held = true

# release anywhere -> drop (left button)
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_held:
			is_held = false
