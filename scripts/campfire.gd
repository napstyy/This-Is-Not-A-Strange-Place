extends Node2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var area: Area2D = $Area2D

@export var normal_texture: Texture2D
@export var lit_texture: Texture2D
@export var light_scene: PackedScene

var current_light: PointLight2D = null

func _ready():
	sprite.texture = normal_texture
	area.area_entered.connect(_on_area_entered)

func _on_area_entered(other_area):
	if other_area.get_parent().is_in_group("water"):
		sprite.texture = lit_texture
		
		if current_light == null and light_scene:
			current_light = light_scene.instantiate()
			add_child(current_light)
			current_light.position = Vector2.ZERO
