extends KinematicBody2D

export var deceleration := 200
export var weight := 1.0

var velocity := Vector2.ZERO

func _physics_process(delta: float):
	velocity = velocity.move_toward(Vector2.ZERO, deceleration * delta)
	
	var collision = move_and_collide(velocity)
	if collision:
		var normalized_weight = max(weight, 1)
		velocity = velocity.bounce(collision.normal) / normalized_weight

func throw(dir: Vector2) -> void:
	velocity = dir
