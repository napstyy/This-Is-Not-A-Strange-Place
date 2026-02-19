extends Node2D

@export var room_name: String
@export var replacement_scenes: Array[PackedScene]
@export var spawn_point: Node2D

func _ready():
	if spawn_point == null:
		push_error("spawn_point is not assigned")
		return

	var items = GameState.get_room_items(room_name)
	
	for id in items:
		if id >= 0 and id < replacement_scenes.size():
			var instance = replacement_scenes[id].instantiate()
			add_child(instance)
			
			if instance is Node2D:
				instance.global_position = spawn_point.global_position
