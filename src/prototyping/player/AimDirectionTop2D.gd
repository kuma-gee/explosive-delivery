class_name AimDirectionTop2D extends Node

export var input_path: NodePath
onready var input := get_node(input_path)

onready var body: KinematicBody2D = get_parent()
onready var aim_mouse = not input.joypad

func _process(_delta):
	var aim_dir = _get_aim_direction(body)
	body.look_at(body.global_position + aim_dir)
	
func _get_aim_direction(node: Node2D) -> Vector2:
	var dir: Vector2
	if aim_mouse:
		dir = node.global_position.direction_to(node.get_global_mouse_position())
	else:
		dir = _input_aim()

	return dir.normalized()

func _input_aim() -> Vector2:
	return Vector2(
		input.get_action_strength("aim_right") - input.get_action_strength("aim_left"),
		input.get_action_strength("aim_down") - input.get_action_strength("aim_up")
	)

