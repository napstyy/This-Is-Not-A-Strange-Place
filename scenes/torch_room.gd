extends Node

@export var room_name: String = ""
@export var prefab_map: Dictionary = {}


var zones_by_name: Dictionary = {}

func _ready():

	for child in get_tree().get_nodes_in_group("room_zones"):
		if child.has_meta("zone_name"):
			zones_by_name[child.get_meta("zone_name")] = child
		elif child.has_method("get_zone_name"):
			zones_by_name[child.get_zone_name()] = child
		elif child.name != "":

			zones_by_name[child.name] = child


	var spawns = GameState.consume_spawns(room_name)
	for spawn in spawns:
		_process_spawn(spawn)

func _process_spawn(spawn: Dictionary) -> void:
	var id = int(spawn.get("id", -1))
	var zone_name = str(spawn.get("zone", ""))
	var world_pos = spawn.get("position", null)

	if not prefab_map.has(id):
		push_error("Room '%s' has no prefab for id %s" % [room_name, str(id)])
		return

	var scene: PackedScene = prefab_map[id]
	var inst = scene.instantiate()
	add_child(inst)


	if zone_name != "" and zones_by_name.has(zone_name):
		var zone_node = zones_by_name[zone_name]
		zone_node.add_child(inst)

		if world_pos != null:

			var local = zone_node.to_local(world_pos)
			if inst is Node2D:
				inst.position = local
			elif inst is Node3D:
				inst.translation = Vector3(local.x, local.y, 0)
	else:

		if world_pos != null:

			if inst is Node2D:
				inst.global_position = world_pos
			elif inst is Node3D:
				inst.global_transform.origin = Vector3(world_pos.x, world_pos.y, 0)
