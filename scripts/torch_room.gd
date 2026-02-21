extends Room_Manager


@onready var letterspawn: Node2D = $Letterspawn
@onready var drop: Area2D = $Drop
@onready var cube_detector: Area2D = $CubeDetector
@onready var cube_detector_2: Area2D = $CubeDetector2
@onready var cube_detector_3: Area2D = $CubeDetector3
@onready var fire_detector: Area2D = $FireDetector

var cube_counter = 0
var is_held = false
var cube_tower_size = 3
var torch_in_zone = false
var tween: Tween

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	cube_detector.cubedetected.connect(_on_cubedetected)
	cube_detector_2.cubedetected.connect(_on_cubedetected)
	cube_detector_3.cubedetected.connect(_on_cubedetected)
	fire_detector.torchdetected.connect(_on_torchdetected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
		

func _on_objComplete():
	#if GameManager.keys["Campfire"] and GameManager.keys["Cart"]:
		#GameManager.keys["OKey"] = true
		#spawnKey()
		pass

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

func _input(event) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		#print("mouse released")
		is_held = false
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		#print("mouse pressed")
		is_held = true


func _on_cubedetected(inc):
	
	#old code - inc is unneeded in the signal, just too lazy to remove atm lol
	#cube_counter+=inc
	#if cube_counter!=cube_detector.get_count()+cube_detector_2.get_count()+cube_detector_3.get_count():
		#print("ERROR" + str(cube_detector.get_count()+cube_detector_2.get_count()+cube_detector_3.get_count()))
	#print(cube_counter)
	
	cube_counter = cube_detector.get_count()+cube_detector_2.get_count()+cube_detector_3.get_count()
	print(cube_counter)
	if torch_in_zone and cube_counter==cube_tower_size and not is_held:
		if not GameManager.keys["TKey"]:
			GameManager.keys["TKey"] = true
			spawnKey()

func _on_torchdetected(state):
	torch_in_zone = state
	print(torch_in_zone)
	#print(cube_counter)
	if torch_in_zone and cube_counter==cube_tower_size and not is_held:
		if not GameManager.keys["TKey"]:
			GameManager.keys["TKey"] = true
			spawnKey()
	#print(torch_in_zone)
