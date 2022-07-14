extends KinematicBody2D

export var speed := 300

var direction = Vector2.RIGHT

func _physics_process(delta):
	move_and_slide(direction * speed)
