extends Node2D

#Progress bar has to start at 7 or else it looks weird
@onready var progress_end: Sprite2D = $ProgressEnd
@onready var texture_progress_bar: TextureProgressBar = $TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	progress_end.position.x = texture_progress_bar.value + 3.0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_texture_progress_bar_value_changed(value: float) -> void:
	progress_end.position.x = value + 3.0
