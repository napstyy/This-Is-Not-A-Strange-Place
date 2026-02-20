# Zone.gd
extends Area2D
var current_room_name
@export var target_room_name: String = ""  # e.g. "Room2"
var idoffset = 6 #the offset mapping labels to their non-label counterparts
var bodyDict = {} #Dictionary of int:ObjType

func _ready() -> void:
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	
	current_room_name = get_tree().current_scene.get_room_name()
	#print(current_room_name)
	
	var count = 0
	for i in GameManager.counters:
		bodyDict[count] = i
		count+=1
	#print(bodyDict)

func _on_body_entered(body: Node) -> void:
	var id := _extract_prefab_id(body)
	#print(id)
	if id == -1:
		return

	#GameState.add_to_room(target_room_name, id)
	#GameState.mark_consumed(id)
	
	if current_room_name == "WordRoom":
		#count down a label
		#print(GameManager.counters["FireLabel"]["WordRoom"])
		GameManager.counters[bodyDict[id]][current_room_name] = GameManager.counters[bodyDict[id]][current_room_name] - 1
		#print(GameManager.counters["FireLabel"]["WordRoom"])
		
		#count up, convert label to other obj
		#print(GameManager.counters["Fire"]["TorchRoom"])
		GameManager.counters[bodyDict[id-idoffset]][target_room_name] = GameManager.counters[bodyDict[id-idoffset]][target_room_name] + 1
		#print(GameManager.counters["Fire"]["TorchRoom"])
	else:
		#count down
		#print(GameManager.counters["Fire"]["TorchRoom"])
		GameManager.counters[bodyDict[id]][current_room_name] = GameManager.counters[bodyDict[id]][current_room_name] - 1
		#print(GameManager.counters["Fire"]["TorchRoom"])
		#count up
		#print(GameManager.counters["FireLabel"]["WordRoom"])
		GameManager.counters[bodyDict[id+idoffset]][target_room_name] = GameManager.counters[bodyDict[id+idoffset]][target_room_name] + 1
		#print(GameManager.counters["FireLabel"]["WordRoom"])
	body.queue_free()

# returns -1 if no id found
func _extract_prefab_id(body: Node) -> int:
	if body == null:
		return -1

	# 1) metadata (preferred)
	if body.has_meta("prefab_id"):
		return int(body.get_meta("prefab_id"))

	# 2) check property list for exported var "prefab_id"
	if body.has_method("get_property_list"):
		for p in body.get_property_list():
			# property list entries are dictionaries with a "name" key
			if p.has("name") and p["name"] == "prefab_id":
				var v = body.get("prefab_id")
				if v != null:
					return int(v)

	# 3) last resort: try get() directly (returns null if property not present)
	if body.has_method("get"):
		var maybe = body.get("prefab_id")
		if maybe != null:
			return int(maybe)

	return -1
