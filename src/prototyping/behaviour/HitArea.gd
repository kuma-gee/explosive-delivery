class_name HitArea extends Area2D

export var knockback_force := 10

func _ready():
	connect("area_entered", self, "_on_area_entered")
	
func _on_area_entered(area):
	if area is HurtArea:
		var knockback = area.global_position - global_position
		area.on_hit(knockback * knockback_force)
