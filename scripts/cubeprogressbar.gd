extends Node2D

#Progress bar has to start at 7 or else it looks weird
@onready var progress_end: Sprite2D = $ProgressEnd
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_end.position.x = texture_progress_bar.value + 3.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	label.text = "Work Efficiency: " + str(int((texture_progress_bar.value/240)*100)) + "%"


func _on_texture_progress_bar_value_changed(value: float) -> void:
	progress_end.position.x = value + 3.0
	
func set_value(value: float):
	texture_progress_bar.value = value

func get_value():
	return texture_progress_bar.value
