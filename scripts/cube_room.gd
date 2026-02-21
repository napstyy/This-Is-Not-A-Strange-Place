extends Room_Manager

@onready var cube_progress_bar: Node2D = $CubeProgressBar
@onready var letterspawn: Node2D = $Letterspawn
@onready var water_cooler: StaticBody2D = $WaterCooler
@onready var treadmill: StaticBody2D = $Treadmill
@onready var drop: Area2D = $Drop


var tween: Tween
var minClamp = 7.0
var maxClamp = 240.0

func _ready() -> void:
	super._ready()
	treadmill.objComplete.connect(_on_objComplete)
	water_cooler.objComplete.connect(_on_objComplete)

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
	
func _on_objComplete():
	if GameManager.keys["Treadmill"] and GameManager.keys["WaterCooler"]:
		GameManager.keys["OKey"] = true
		spawnKey()

func spawnKey():
	letterspawn.set_visible(true)
	reset_tween()
	tween.tween_property(letterspawn,"global_position",drop.get_position(),3.0)
	await tween.finished
	letterspawn.set_visible(false)

#used for animations
func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
