extends Area2D


@export var mouseCursor: AnimatedSprite2D
@export var hoverCursor: String #change depending on which cursor is needed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#on mouse hover, change sprite to hoverCursor
func _on_mouse_entered() -> void:
	mouseCursor.play(hoverCursor)
	#print("entered")


func _on_mouse_exited() -> void:
	mouseCursor.play("default")
	#print("exit")
	
