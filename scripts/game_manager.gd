extends Node

var counters = {
	#Counters get accessed when portal activated
	"CubePeople": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #0
	"SpherePeople": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #1
	"Human": {"CubeRoom": 0, "CaveRoom": 3, "TorchRoom": 0, "WordRoom":0}, #2
	"Animal": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #3
	"Fire": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 1, "WordRoom":0}, #4
	"Water": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #5
	"CubeLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0},#6
	"SphereLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #7
	"HumanLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #8
	"AnimalLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #9
	"FireLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0}, #10
	"WaterLabel": {"CubeRoom": 0, "CaveRoom": 0, "TorchRoom": 0, "WordRoom":0} #11
	}
	
var keys = {
	"WaterCooler": false,
	"Treadmill": false,
	"Campfire": false,
	"Cart": false,
	}

var replacement_scenes = {
	0: preload("res://prefabs/CubeGuy.tscn"),
	1: preload("res://prefabs/SphereGuy.tscn"),
	2: preload("res://prefabs/Human.tscn"),
	3: preload("res://prefabs/Animal.tscn"),
	4: preload("res://prefabs/Torch.tscn"),
	5: preload("res://prefabs/Water.tscn"),
	6: preload("res://prefabs/SquareLabel.tscn"),
	7: preload("res://prefabs/CircleLabel.tscn"),
	8: preload("res://prefabs/ManLabel.tscn"),
	9: preload("res://prefabs/AnimalLabel.tscn"),
	10: preload("res://prefabs/FireLabel.tscn"),
	11: preload("res://prefabs/WaterLabel.tscn")
	}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
