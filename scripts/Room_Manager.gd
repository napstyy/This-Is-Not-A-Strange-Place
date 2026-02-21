class_name Room_Manager
extends Node2D

@export var room_name: String
#@export var replacement_scenes: Dictionary[int, PackedScene] #Make sure this matches ObjectID
enum ObjectID {CUBE, SPHERE, HUMAN, ANIMAL, FIRE, WATER, CUBELABEL, SPHERELABEL, HUMANLABEL, ANIMALLABEL, FIRELABEL, WATERLABEL}
var idDict = {} #Dictionary of ObjType:int
@export var spawn_point: Node2D
var spawn_points = {} #Spawns on spawners using ID & their position


func _ready():
	if spawn_point == null:
		push_error("spawn_point is not assigned")
		return
	
	#Generating idDict, to iterate through replacement scenes in a cleaner way
	var count = 0
	for i in GameManager.counters:
		idDict[i] = count
		count+=1
	
	#For use with spawn with override
	for i in range(GameManager.counters.size()):
		spawn_points[i] = []
		for x in get_tree().get_nodes_in_group("spawners"):
			if x.get_ID() == i:
				spawn_points[i].append(x.get_pos())
	
	spawn_with_override()
	
	#OldCode
	#var items = GameState.get_room_items(room_name)
	#
	#for id in items:
		#if id >= 0 and id < replacement_scenes.size():
			#var instance = replacement_scenes[id].instantiate()
			#add_child(instance)
			#
			#if instance is Node2D:
				#instance.global_position = spawn_point.global_position

#Use this if you just have 1 generic spawner
func spawn():
	#Check counters & spawn things, Room code has to remove anything that is there by default
	for instances in GameManager.counters: #For each object type, spawn them if counter > 0
		if GameManager.counters[instances][room_name]>0:
			for i in GameManager.counters[instances][room_name]:
						var newObj = GameManager.replacement_scenes[idDict[instances]].instantiate()
						add_child(newObj)
						#print(newObj)
						if newObj is Node2D:
							newObj.global_position = spawn_point.global_position


#Use this if you're using IDs for spawners
func spawn_with_override():
	#Check counters & spawn things, Room code has to remove anything that is there by default
	for instances in GameManager.counters: #For each object type, spawn them if counter > 0
		if GameManager.counters[instances][room_name]>0:
			var count = 0
			for i in GameManager.counters[instances][room_name]:
						var newObj = GameManager.replacement_scenes[idDict[instances]].instantiate()
						add_child(newObj)
						if count >= spawn_points[idDict[instances]].size(): #Generic spawner
							if newObj is Node2D:
								newObj.global_position = spawn_point.global_position + Vector2(count,0)
								count+=1
						else:
							if newObj is Node2D:
								newObj.global_position = spawn_points[idDict[instances]][count]	
							count += 1
	
func get_room_name():
	return room_name
