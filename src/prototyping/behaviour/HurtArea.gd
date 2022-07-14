class_name HurtArea extends Area2D

signal hit(knockback)

func on_hit(knockback: Vector2):
	emit_signal("hit", knockback)
