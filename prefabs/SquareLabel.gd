extends RigidBody2D

# --- Config ---
@export var pick_radius := 48.0   # fallback distance in pixels for click pickup

# --- State ---
var is_held := false
var snap_target = null  # nullable Vector2

@onready var col_shape := $CollisionShape2D

func _ready():
	sleeping = false  # physics active by default

# Primary pick path: works if CollisionShape2D Input Pickable is ON
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		_pick_up()

# Fallback pick path: runs even if another collision is blocking _input_event
func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_held:
			return
		var mp = get_global_mouse_position()
		if mp.distance_to(global_position) <= pick_radius:
			_pick_up()

# Release anywhere -> drop and snap if snap_target exists
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		if is_held:
			_release()

func _physics_process(delta):
	if is_held:
		# follow mouse
		global_position = get_global_mouse_position()
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true
	elif snap_target != null:
		# keep snapped position frozen
		global_position = snap_target
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true

# --- Pick up ---
func _pick_up():
	is_held = true
	sleeping = true
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	# clear snap so it moves freely
	snap_target = null

# --- Release ---
func _release():
	is_held = false
	if snap_target != null:
		# stay snapped and frozen
		global_position = snap_target
		linear_velocity = Vector2.ZERO
		angular_velocity = 0
		sleeping = true
	else:
		# physics resumes
		sleeping = false

# --- API used by Area2D slot ---
func set_snap_target(center):
	snap_target = center

func clear_snap_target():
	snap_target = null

func is_currently_held() -> bool:
	return is_held
