extends Area2D

@export var target_room: String = ""
@export var target_zone: String = ""

func _ready():
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	var id: int = -1
	if body.has_method("get_prefab_id"):
		id = body.get_prefab_id()
	elif body.has_meta("prefab_id"):
		id = int(body.get_meta("prefab_id"))
	elif "prefab_id" in body:
		id = int(body.prefab_id)
	else:
		return

	var spawn: Dictionary = {
		"id": id,
		"zone": target_zone,
		"position": body.global_position
	}

	GameState.add_spawn(target_room, spawn)

	body.queue_free()
