class_name Projectile2D extends Node

export var deceleration := 500
export var weight := 1.0

onready var body: KinematicBody2D = get_parent()

var velocity := Vector2.ZERO

func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	var collision = body.move_and_collide(velocity)
	if collision:
		var normalized_weight = max(weight, 1)
		velocity = velocity.bounce(collision.normal) / normalized_weight
