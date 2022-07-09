class_name PickupArea extends Area2D

onready var pickup_item: PickupItem = get_parent()

var logger = Logger.new("PickupArea")
var pickup_owner: Node2D setget _set_pickup_owner

func _set_pickup_owner(node: Node2D):
	pickup_owner = node
	monitorable = not node
	monitoring = not node


func _process(delta):
	if pickup_owner:
		pickup_item.global_position = pickup_owner.global_position
		pickup_item.global_rotation = pickup_owner.global_rotation


func picked_up_by(hand: Node2D):
	if pickup_owner:
		logger.debug("already picked up by another owner")
		return
	
	self.pickup_owner = hand


func place_item():
	self.pickup_owner = null

func throw_item(dir: Vector2):
	self.pickup_owner = null
	pickup_item.throw(dir)
