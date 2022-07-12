extends PickupItem

export var explosion_timer = 5.0

onready var timer := $Timer

func _on_PickupArea_picked_up():
	timer.start(explosion_timer)


func _on_Timer_timeout():
	queue_free()
