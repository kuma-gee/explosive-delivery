class_name PickupItem extends KinematicBody2D

onready var projectile: Projectile2D = $Projectile2D

var logger = Logger.new("PickupItem")

func throw(dir: Vector2):
	projectile.velocity = dir
