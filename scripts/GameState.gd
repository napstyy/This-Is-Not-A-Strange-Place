extends Node

# room_name -> array of prefab_ids that should exist in that room
var room_contents := {}

# optional: track which items are already used so they don’t respawn in main room
var consumed_ids := {}

func add_to_room(room_name: String, prefab_id: int) -> void:
	if not room_contents.has(room_name):
		room_contents[room_name] = []
	room_contents[room_name].append(prefab_id)

func get_room_items(room_name: String) -> Array:
	if not room_contents.has(room_name):
		return []
	return room_contents[room_name]

func mark_consumed(prefab_id: int) -> void:
	consumed_ids[prefab_id] = true

func is_consumed(prefab_id: int) -> bool:
	return consumed_ids.has(prefab_id)
