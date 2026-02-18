extends Area2D

@export var hoverSprite: AnimatedSprite2D
@export var defaultSprite: AnimatedSprite2D
var defaultframes

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	defaultframes = defaultSprite.sprite_frames
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#on mouse hover, change sprite to mouseSprite
func _on_mouse_entered() -> void:
	defaultSprite.sprite_frames = hoverSprite.sprite_frames
	print("entered")


func _on_mouse_exited() -> void:
	defaultSprite.sprite_frames = defaultframes
	
