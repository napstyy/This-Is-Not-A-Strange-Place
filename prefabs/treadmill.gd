extends StaticBody2D

@onready var area: Area2D = $Area2D 
@onready var animalsprite: Sprite2D = $AnimalSprite
@onready var treadmillsprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var animalanim: AnimationPlayer = $AnimalSprite/AnimationPlayer


func _ready():
	area.body_entered.connect(_on_body_entered)
	animalsprite.visible = false
	if GameManager.keys["Treadmill"]==true:
		treadmillsprite.play("default")
		animalanim.play("walk")
		animalsprite.set_visible(true)


func _on_body_entered(body):
	if body.is_in_group("animal"):
		animalsprite.visible = true
		treadmillsprite.play("default")
		animalanim.play("walk")
		body.queue_free()
		GameManager.keys["Treadmill"]=true
		GameManager.counters["Animal"]["CubeRoom"] = GameManager.counters["Animal"]["CubeRoom"] - 1
