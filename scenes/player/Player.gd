class_name Player extends KinematicBody2D

func set_input(input: PlayerInput) -> void:
	$PlayerController.input = input
