extends Area2D

@export var color_rect_path: NodePath
@export var replacement_scenes: Array[PackedScene] = []

var current_snapped: Node = null

func _ready():
	if not is_connected("body_entered", Callable(self, "_on_body_entered")):
		connect("body_entered", Callable(self, "_on_body_entered"))
	if not is_connected("body_exited", Callable(self, "_on_body_exited")):
		connect("body_exited", Callable(self, "_on_body_exited"))

	if color_rect_path != NodePath(""):
		var cr = get_node_or_null(color_rect_path)
		if cr and cr.has_signal("color_toggled"):
			cr.connect("color_toggled", Callable(self, "_on_color_toggled"))

func _on_body_entered(body: Node) -> void:
	if body == null:
		return
	if body.has_method("set_snap_target") and body.has_method("is_currently_held") and body.call("is_currently_held"):
		body.call("set_snap_target", global_position, self)
		# body will call register_snapped_body when set_snap_target runs

func _on_body_exited(body: Node) -> void:
	if body == null:
		return
	if body.has_method("clear_snap_target"):
		body.call("clear_snap_target")

func register_snapped_body(body: Node) -> void:
	current_snapped = body

func unregister_snapped_body(body: Node) -> void:
	if current_snapped == body:
		current_snapped = null

func replace_snapped_body_reference(old_body: Node, new_body: Node) -> void:
	if current_snapped == old_body:
		current_snapped = new_body

func _on_color_toggled(_is_black: bool) -> void:
	if current_snapped == null:
		return
	if not current_snapped.has_method("replace_with_scene"):
		return

	var id: int = current_snapped.prefab_id
	if id < 0 or id >= replacement_scenes.size():
		push_warning("Invalid prefab_id: %d" % id)
		return

	var target_scene: PackedScene = replacement_scenes[id]
	if target_scene == null:
		push_warning("Replacement scene at index %d is null" % id)
		return

	# replace and get the new node
	var new_node = current_snapped.replace_with_scene(target_scene)
	if new_node == null:
		return


	if new_node.has_method("clear_snap_target"):
		new_node.call("clear_snap_target")
	if new_node is RigidBody2D:
		new_node.sleeping = false

	current_snapped = null
