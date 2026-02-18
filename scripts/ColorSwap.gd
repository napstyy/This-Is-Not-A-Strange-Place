extends ColorRect

signal color_toggled(is_black: bool)

var is_black := true

@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	_update_color()

func _on_timer_timeout():
	is_black = not is_black
	_update_color()
	emit_signal("color_toggled", is_black)

func _update_color():
	if is_black:
		color = Color.BLACK
	else:
		color = Color(0.99,0.95,0.81,0)
