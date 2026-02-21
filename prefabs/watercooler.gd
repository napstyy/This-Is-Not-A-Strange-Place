extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

@export var normal_texture: Texture2D
@export var lit_texture: Texture2D
signal objComplete
func _ready():
	area.area_entered.connect(_on_area_entered)
	if GameManager.keys["WaterCooler"]:
		sprite.texture = lit_texture
func _on_area_entered(other_area):
	if other_area.get_parent().is_in_group("water"):
		sprite.texture = lit_texture
		GameManager.keys["WaterCooler"] = true
		objComplete.emit()#this has to come after setting key to true
		print("WaterCooler key set to: ", GameManager.keys["WaterCooler"])
