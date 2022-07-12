class_name PlayerController extends Node

signal dash()
signal interact_pressed()
signal interact_released()

var input: PlayerInput

func _ready():
	input.connect("just_pressed", self, "_on_just_pressed")
	input.connect("just_released", self, "_on_just_released")

func _on_just_pressed(action: String):
	if action == "interact":
		emit_signal("interact_pressed")

func _on_just_released(action: String):
	if action == "dash":
		emit_signal("dash")
	elif action == "interact":
		emit_signal("interact_released")

func get_look_direction(node: Node2D) -> Vector2:
	var dir: Vector2
	if _aim_mouse():
		dir = node.global_position.direction_to(node.get_global_mouse_position())
	else:
		dir = _input_aim()

	return dir.normalized()

func _aim_mouse() -> bool:
	return not input.joypad

func _input_aim() -> Vector2:
	return Vector2(
		input.get_action_strength("aim_right") - input.get_action_strength("aim_left"),
		input.get_action_strength("aim_down") - input.get_action_strength("aim_up")
	)

func get_move_direction() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
