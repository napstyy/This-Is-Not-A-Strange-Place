extends Room_Manager

@export var letter_n: Node2D
@export var letter_o: Node2D
@export var letter_t: Node2D
var tween: Tween
var LetterPos = {}
var LetterDestination = [Vector2(725.0,258.0), Vector2(790.0, 258.0), Vector2(855.0, 258.0)]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	LetterPos.set(letter_n, letter_n.get_position())
	LetterPos.set(letter_o, letter_o.get_position())
	LetterPos.set(letter_t, letter_t.get_position())
	#print(LetterPos)
	letterCheck()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func letterCheck():
	if (GameManager.keys["NKey"]):
		letter_n.set_visible(true)
	if (GameManager.keys["OKey"]):
		letter_o.set_visible(true)
	if (GameManager.keys["TKey"]):
		letter_t.set_visible(true)
	if (GameManager.keys["NKey"] and GameManager.keys["OKey"] and GameManager.keys["TKey"]):
			reset_tween()
			tween.tween_property(letter_n, "global_position", LetterDestination[0], 1.0)
			tween.tween_property(letter_o, "global_position", LetterDestination[1], 1.0)
			tween.tween_property(letter_t, "global_position", LetterDestination[2], 1.0)

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()
