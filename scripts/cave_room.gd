extends Room_Manager

@onready var campfire: StaticBody2D = $Campfire
@onready var cart: StaticBody2D = $RigidBody2D
@onready var letterspawn: Node2D = $Letterspawn
@onready var drop: Area2D = $Drop

var tween: Tween
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	campfire.objComplete.connect(_on_objComplete)
	cart.objComplete.connect(_on_objComplete)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_objComplete():
	if GameManager.keys["Campfire"] and GameManager.keys["Cart"]:
		GameManager.keys["NKey"] = true
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
