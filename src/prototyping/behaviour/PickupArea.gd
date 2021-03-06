class_name PickupArea extends Area2D

signal picked_up()
signal placed_down()

onready var pickup_item = get_parent()

var logger = Logger.new("PickupArea")
var pickup_owner: Node2D setget _set_pickup_owner

func _set_pickup_owner(node: Node2D):
	pickup_owner = node
	monitorable = not node
	monitoring = not node
	
	if node:
		emit_signal("picked_up")
	else:
		emit_signal("placed_down")


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
	if pickup_item.has_method("throw"):
		pickup_item.throw(dir)
