extends Area2D


signal torchdetected(state)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	#print("detected")
	for x in get_overlapping_bodies():
		if x.is_in_group("torch"):
			#print("torch entered")
			torchdetected.emit(true)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("torch"):
		#print("torch left")
		torchdetected.emit(false)
