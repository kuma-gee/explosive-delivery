class_name Player extends KinematicBody2D

onready var knockback := $Knockback

func set_input(input: PlayerInput) -> void:
	$PlayerController.input = input
 
func apply_knockback(dir: Vector2) -> void:
	knockback.velocity = dir

