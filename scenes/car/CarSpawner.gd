extends Position2D

export var car_scene: PackedScene

export var speed := 100

export var min_delay := 2.0
export var max_delay := 6.0

onready var timer := $Timer

func _ready():
	_start_next_spawn_with_delay()

func _on_Timer_timeout():
	var car = car_scene.instance()
	car.direction = Vector2.RIGHT.rotated(global_rotation)
	car.speed = speed
	
	get_tree().current_scene.add_child(car)
	car.global_position = global_position
	car.global_rotation = global_rotation
	
	_start_next_spawn_with_delay()

func _start_next_spawn_with_delay():
	var delay = rand_range(min_delay, max_delay)
	timer.start(delay)
