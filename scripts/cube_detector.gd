extends Area2D


signal cubedetected(increment)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	for x in get_overlapping_bodies():
		if x.is_in_group("cube"):
			#print("cube entered")
			cubedetected.emit(1)

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("cube"):
		#print("cube left")
		cubedetected.emit(-1)

func get_count():
	return get_overlapping_bodies().size()
