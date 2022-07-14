class_name DestroyOnLeave extends Area2D

func _ready():
	connect("body_exited", self, "_on_body_exit")
	

func _on_body_exit(body: Node2D):
	body.queue_free()
