class_name PickupItem extends KinematicBody2D

export var pickup_item: PackedScene

onready var projectile: Projectile2D = $Projectile2D

var logger = Logger.new("PickupItem")

func throw(dir: Vector2):
	projectile.velocity = dir
