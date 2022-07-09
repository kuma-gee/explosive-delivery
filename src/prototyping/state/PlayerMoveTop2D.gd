class_name PlayerMoveTop2D extends Node

export var acceleration := 1000
export var deceleration := 1000
export var max_speed := 500

export var input_path: NodePath
onready var input := get_node(input_path)

onready var body: KinematicBody2D = get_parent()

var velocity = Vector2.ZERO

func _physics_process(delta):
	var direction = _get_motion()
	var desired_velocity = direction * max_speed
	
	var is_moving = direction.length() > 0.01
	var max_speed_change = acceleration if is_moving else deceleration
	
	velocity = velocity.move_toward(desired_velocity, max_speed_change * delta)
	velocity = body.move_and_slide(velocity)


func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
