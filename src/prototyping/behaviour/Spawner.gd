class_name Spawner extends Timer

export(Array, PackedScene) var spawn_objects

var random = RandomNumberGenerator.new()

func _ready():
	connect("timeout", self, "_on_timeout")

func _on_timeout():
	var point = _get_random_spawn_point()
	var obj = _get_random_spawn_object().instance()
	
	get_tree().current_scene.add_child(obj)
	obj.global_position = point.global_position
	
func _get_random_spawn_point() -> Position2D:
	var positions = []
	for child in get_children():
		if child is Position2D:
			positions.append(child)
	
	var idx = random.randi_range(0, positions.size() - 1)
	return positions[idx]

func _get_random_spawn_object() -> PackedScene:
	var idx = random.randi_range(0, spawn_objects.size() - 1)
	return spawn_objects[idx]
