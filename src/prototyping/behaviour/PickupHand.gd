extends Area2D

export var input_path: NodePath
onready var input: PlayerInput = get_node(input_path)

var holding_item: PickupItem
var item: Node2D

func _unhandled_input(_event):
	if input.is_just_pressed("interact"):
		if not holding_item:
			_pickup_item()
		else:
			_place_item()
				
func _pickup_item():
	for area in get_overlapping_areas():
		if area is PickupItem:
			holding_item = area.duplicate()
			item = area.pickup_item.instance()
			add_child(item)
			item.position = Vector2.ZERO
			area.queue_free()
			
func _place_item():
	get_tree().current_scene.add_child(holding_item)
	holding_item.global_position = global_position
	holding_item = null
	item.queue_free()
	
