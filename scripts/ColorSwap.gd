extends ColorRect

var is_black := true

@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)

func _on_timer_timeout():
	is_black = !is_black
	
	if is_black:
		color = Color.BLACK
	else:
		color = Color.WHITE
