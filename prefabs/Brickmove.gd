extends StaticBody2D

@onready var area: Area2D = $Area2D 
@onready var guysprite: AnimatedSprite2D = $Guysprite
@onready var cartsprite: AnimatedSprite2D = $Cartsprite
@onready var spherewheel: Sprite2D = $Cartsprite/Sprite2D
@onready var animation_player: AnimationPlayer = $Cartsprite/Sprite2D/AnimationPlayer
signal objComplete

var is_pushed: bool = false
var push_speed: float = 25.0

func _ready():
	area.body_entered.connect(_on_body_entered)
	guysprite.play()
	if GameManager.keys["Cart"]:
		self.queue_free() #Decided to remove the cart if you succeed its check
func _physics_process(delta):
	if is_pushed:
		global_position.x += push_speed * delta

func _on_body_entered(body):
	if body.is_in_group("circle"):
		guysprite.stop()
		cartsprite.play("push")
		is_pushed = true
		spherewheel.set_visible(true)
		animation_player.play("sphereroll")
		GameManager.keys["Cart"] = true
		objComplete.emit()
