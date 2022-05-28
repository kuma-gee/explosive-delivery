class_name AimDirection extends Node

export var input_path: NodePath
onready var input := get_node(input_path)

onready var aim_mouse = not input.joypad_input

var aim_dir: Vector2

func _process(_delta):
	var dir = _input_aim()
	if dir.length() > 0.1:
		aim_dir = dir
	
func _input_aim() -> Vector2:
	return Vector2(
		input.get_action_strength("aim_right") - input.get_action_strength("aim_left"),
		input.get_action_strength("aim_down") - input.get_action_strength("aim_up")
	)

func get_aim_direction(node: Node2D) -> Vector2:
	var dir: Vector2
	if aim_mouse:
		dir = node.global_position.direction_to(node.get_global_mouse_position())
	else:
		dir = aim_dir
	
	return dir.normalized()
