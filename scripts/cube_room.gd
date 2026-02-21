extends Room_Manager

@onready var cube_progress_bar: Node2D = $CubeProgressBar

var minClamp = 7.0
var maxClamp = 240.0

func _ready() -> void:
	super._ready()

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	#print("WaterCooler: ", GameManager.keys.get("WaterCooler", false), " Treadmill: ", GameManager.keys.get("Treadmill", false))
	
	var increment: float
	var currentMax: float

	if GameManager.keys.get("WaterCooler", false) and GameManager.keys.get("Treadmill", false):
		increment = RandomNumberGenerator.new().randf_range(5.0, 15.0)
		currentMax = 240.0  # was 100.0, but 240 is the actual 100% mark
	else:
		increment = RandomNumberGenerator.new().randf_range(-6.0, 3.0)
		currentMax = 40.0

	cube_progress_bar.set_value(clamp(cube_progress_bar.get_value() + increment, minClamp, currentMax))
