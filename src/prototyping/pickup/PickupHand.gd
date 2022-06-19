extends Area2D

export var input_path: NodePath
onready var input: PlayerInput = get_node(input_path)

export var max_throw_strength = 50

var holding_item: PickupItem
var item: Node2D

var throw_strength = 0
var throw_activate_threshold = 0.2

var interact_pressing = -1

func _ready():
	input.connect("just_released", self, "_on_just_released")
	input.connect("just_pressed", self, "_on_just_pressed")

func _on_just_released(action: String):
	if action == "interact":
		interact_pressing = -1
		
		if not holding_item:
			_pickup_item()
		else:
			if throw_strength > 0:
				print(throw_strength)
				throw_strength = 0
			else:
				_place_item()
			

func _on_just_pressed(action: String):
	if action == "interact":
		interact_pressing = 0
			

func _process(delta):
	if interact_pressing >= 0:
		interact_pressing += delta
		print("increase: " + str(interact_pressing))
	
	if interact_pressing >= throw_activate_threshold and holding_item:
		throw_strength = clamp(throw_strength + 1, 0, max_throw_strength)


func _pickup_item():
	var closest_item = null
	var closest_item_dot_scale = -1
	for area in get_overlapping_areas():
		if area is PickupItem:
			if closest_item == null:
				closest_item = area
			else:
				var item_dir = (global_position + area.global_position).normalized()
				var hand_dir = Vector2.RIGHT.rotated(global_rotation)
				var dot_scale = item_dir.dot(hand_dir)
				
				if dot_scale > closest_item_dot_scale:
					closest_item = area
					closest_item_dot_scale = dot_scale

	if closest_item:
		holding_item = closest_item.duplicate()
		item = holding_item.pickup_item.instance()
		add_child(item)
		item.position = Vector2.ZERO
		closest_item.queue_free()


func _place_item():
	get_tree().current_scene.add_child(holding_item)
	holding_item.global_position = global_position
	holding_item = null
	item.queue_free()

