class_name PlayerMoveTop2D extends Node

export var speed := 500

export var input_path: NodePath
onready var input := get_node(input_path)

onready var body: KinematicBody2D = get_parent()

func _physics_process(_delta):
	var dir = _get_motion()
	body.move_and_slide(dir * speed)


func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
