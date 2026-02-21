extends Room_Manager

@onready var cube_progress_bar: Node2D = $CubeProgressBar

var minClamp = 7.0
var maxClamp = 240.0

@export var spawn_scene: PackedScene
@export var letterspawn: Node2D

var letters = ["N", "O", "T"]

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	var increment: float
	var currentMax: float

	if GameManager.keys.get("WaterCooler", false) and GameManager.keys.get("Treadmill", false):
		increment = RandomNumberGenerator.new().randf_range(5.0, 15.0)
		currentMax = 240.0
	else:
		increment = RandomNumberGenerator.new().randf_range(-6.0, 3.0)
		currentMax = 40.0

	cube_progress_bar.set_value(clamp(cube_progress_bar.get_value() + increment, minClamp, currentMax))

	if cube_progress_bar.get_value() >= 240.0:
		spawn_sprite()

func spawn_sprite() -> void:
	var instance = spawn_scene.instantiate()
	add_child(instance)
	instance.global_position = letterspawn.global_position
	print(instance.get_children())
