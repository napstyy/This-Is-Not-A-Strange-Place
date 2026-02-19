extends Room_Manager

#Progress Bar
@onready var cube_progress_bar: Node2D = $CubeProgressBar
var minClamp = 7.0 #Set min & max for bar clamping. Bar goes from 7-240, can use other intervals to be more accurate for progress
var maxClamp = 240.0
var incrementMax = 5.0 #min & max range for value added every timeout
var incrementMin = -5.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	super._ready()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_timer_timeout() -> void:
	cube_progress_bar.set_value(clamp(cube_progress_bar.get_value() + RandomNumberGenerator.new().randf_range(incrementMin,incrementMax), minClamp, maxClamp))
