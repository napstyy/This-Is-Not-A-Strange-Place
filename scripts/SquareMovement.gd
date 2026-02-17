extends CharacterBody2D

@export var speed := 100
@export var min_pause := 0.5
@export var max_pause := 2.0
@export var min_walk := 1.0
@export var max_walk := 3.0

var direction := 0
var state := "idle"
var timer := 0.0

func _ready():
	pick_new_state()

func _physics_process(delta):
	# Apply gravity
	if not is_on_floor():
		velocity.y += get_gravity().y * delta

	timer -= delta

	if timer <= 0:
		pick_new_state()

	if state == "walk":
		velocity.x = direction * speed
	else:
		velocity.x = 0



	move_and_slide()


func pick_new_state():
	if randi() % 2 == 0:
		# WALK
		state = "walk"
		direction = [-1, 1].pick_random()
		timer = randf_range(min_walk, max_walk)
	else:
		# IDLE (pause)
		state = "idle"
		timer = randf_range(min_pause, max_pause)
