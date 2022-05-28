extends KinematicBody2D

onready var input := $PlayerInput
onready var aim_direction := $AimDirection

export var speed := 500

func _process(delta):
	var aim_dir = aim_direction.get_aim_direction(self)
	look_at(global_position + aim_dir)

func _physics_process(_delta):
	var dir = _get_motion()
	move_and_slide(dir * speed)


func _get_motion() -> Vector2:
	return Vector2(
		input.get_action_strength("move_right") - input.get_action_strength("move_left"),
		input.get_action_strength("move_down") - input.get_action_strength("move_up")
	)
