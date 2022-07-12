class_name PlayerMoveTop2D extends Node

export var acceleration := 1000
export var deceleration := 1000
export var max_speed := 500
export var dash_speed := 50

export var controller_path: NodePath
onready var controller: PlayerController = get_node(controller_path)

onready var body: Player = get_parent()

onready var projectile: Projectile2D = $Projectile2D
onready var dash_timer: Timer = $DashTimer

var logger = Logger.new("PlayerMoveTop2D")
var velocity = Vector2.ZERO
var can_dash = true

func _ready():
	controller.connect("dash", self, "_on_dash")


func _on_dash():
	if dash_speed > 0 and can_dash:
		var player_dir = velocity if velocity.length() > 0.01 else Vector2.RIGHT.rotated(body.global_rotation)
		var dir = player_dir.normalized()
		
		projectile.velocity = dir * dash_speed
		can_dash = false
		dash_timer.start()


func _physics_process(delta):
	var direction = controller.get_move_direction()
	var desired_velocity = direction * max_speed
	
	var is_moving = direction.length() > 0.01
	var max_speed_change = acceleration if is_moving else deceleration
	
	velocity = velocity.move_toward(desired_velocity, max_speed_change * delta)
	
	var collision = body.move_and_collide(velocity * delta)
	if collision and collision.collider.has_method("apply_knockback"):
		var dir = body.global_position.direction_to(collision.collider.global_position).normalized()
		logger.debug("Applying knockback: %s" % dir)
		print(collision.collider_velocity)
		collision.collider.apply_knockback(dir)



func _on_DashTimer_timeout():
	can_dash = true
