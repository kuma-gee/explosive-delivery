class_name FreeOnExit2D extends VisibilityNotifier2D

onready var node = get_parent()

func _ready():
	connect("screen_exited", self, "_on_screen_exit")
	
func _on_screen_exit():
	node.queue_free()
