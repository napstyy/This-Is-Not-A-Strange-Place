extends Node

var room_spawns: Dictionary = {}  

func add_spawn(room_name: String, spawn: Dictionary) -> void:
	if not room_spawns.has(room_name):
		room_spawns[room_name] = []
	room_spawns[room_name].append(spawn)


func consume_spawns(room_name: String) -> Array:
	if not room_spawns.has(room_name):
		return []
	var arr = room_spawns[room_name]
	room_spawns.erase(room_name)
	return arr
