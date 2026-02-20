extends Node2D

@export var spawnID = 13
var pos = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("spawners")
	pos = global_position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func get_ID():
	return spawnID
	
func get_pos():
	return pos
