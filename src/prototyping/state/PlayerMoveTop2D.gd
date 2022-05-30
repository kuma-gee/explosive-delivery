class_name PlayerMoveTop2D extends Node

export var speed := 500
export var sprint_speed := 800

export var input_path: NodePath
onready var input := get_node(input_path)

onready var body: KinematicBody2D = get_parent()

onready var current_speed = speed

func _process(_delta):
	current_speed = sprint_speed if input.is_pressed("sprint") else speed

func _physics_process(_delta):
	var dir = _get_motion()
	body.move_and_slide(dir * current_speed)


func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
