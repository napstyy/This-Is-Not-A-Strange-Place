class_name Room_Manager
extends Node2D

@export var room_name: String
#@export var replacement_scenes: Dictionary[int, PackedScene] #Make sure this matches ObjectID
enum ObjectID {CUBE, SPHERE, HUMAN, ANIMAL, FIRE, WATER, CUBELABEL, SPHERELABEL, HUMANLABEL, ANIMALLABEL, FIRELABEL, WATERLABEL}
var idDict = {}
@export var spawn_point: Node2D
var spawn_override = [] #Maybe useful for positioning the spawns (does nothing currently)

func _ready():
	if spawn_point == null:
		push_error("spawn_point is not assigned")
		return
	
	#Generating idDict, to iterate through replacement scenes in a cleaner way
	var count = 0
	for i in GameManager.counters:
		idDict[i] = count
		count+=1
	print(idDict)
	spawn()
	
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
	
func spawn():
	#Check counters & spawn things, Room code has to remove anything that is there by default
	for instances in GameManager.counters: #For each object type, spawn them if counter > 0
		if GameManager.counters[instances][room_name]>0:
			for i in GameManager.counters[instances][room_name]:
						var newObj = GameManager.replacement_scenes[idDict[instances]].instantiate()
						add_child(newObj)
						if newObj is Node2D:
							newObj.global_position = spawn_point.global_position
