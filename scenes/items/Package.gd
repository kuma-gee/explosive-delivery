extends KinematicBody2D

export var deceleration := 300
export var weight := 1.0

var velocity := Vector2.ZERO

func _physics_process(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, deceleration * weight * delta)
	
	var collision = move_and_collide(velocity)
	if collision:
		velocity = velocity.bounce(collision.normal)

func throw(dir: Vector2) -> void:
	velocity = dir
