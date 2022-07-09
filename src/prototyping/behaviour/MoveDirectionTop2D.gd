class_name MoveDirectionTop2D extends Node

export var direction := Vector2.RIGHT
export var speed := 300

onready var body: KinematicBody2D = get_parent()

func _physics_process(delta):
	body.move_and_slide(direction * speed)
