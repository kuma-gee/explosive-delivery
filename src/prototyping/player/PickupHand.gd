extends Area2D

export var controller_path: NodePath
onready var controller: PlayerController = get_node(controller_path)

export var max_throw_strength := 50

var logger = Logger.new("PickupHand")

var holding_item: PickupArea

var throw_strength = 0
var throw_activate_threshold = 0.2
var interact_pressing = -1

func _ready():
	controller.connect("interact_pressed", self, "_on_interact_pressed")
	controller.connect("interact_released", self, "_on_interact_released")

func _on_interact_released():
	interact_pressing = -1
	
	if not holding_item or not is_instance_valid(holding_item):
		_pickup_item()
	else:
		if throw_strength > 0:
			var dir = Vector2.RIGHT.rotated(global_rotation)
			holding_item.throw_item(dir * throw_strength)
			holding_item = null
			throw_strength = 0
		else:
			_place_item()
			

func _on_interact_pressed():
	interact_pressing = 0
			

func _process(delta):
	if interact_pressing >= 0:
		interact_pressing += delta
	
	if interact_pressing >= throw_activate_threshold and holding_item:
		throw_strength = clamp(throw_strength + 1, 0, max_throw_strength)


func _pickup_item():
	var closest_item: PickupArea = null
	var closest_item_dot_scale = -1
	for area in get_overlapping_areas():
		if area is PickupArea:
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
		closest_item.picked_up_by(self)
		holding_item = closest_item

func _place_item():
	holding_item.place_item()
	holding_item = null

