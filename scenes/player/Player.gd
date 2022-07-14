class_name Player extends KinematicBody2D

export var acceleration := 2000
export var deceleration := 2000
export var max_speed := 500
export var dash_speed := 1000

onready var controller: PlayerController = $PlayerController
onready var soft_collision := $SoftCollision

var velocity = Vector2.ZERO

func _ready():
	controller.connect("dash", self, "_dash")


func set_input(input: PlayerInput) -> void:
	$PlayerController.input = input


func _process(_delta):
	var aim_dir = controller.get_look_direction(self)
	look_at(global_position + aim_dir)


func _physics_process(delta):
	_move(delta)
	_apply_soft_collision(delta)
	
	velocity = move_and_slide(velocity)


func _move(delta: float):
	var move_dir = controller.get_move_direction()
	var desired_velocity = move_dir.normalized() * max_speed
	
	var is_moving = move_dir.length() > 0.01
	var max_speed_change = acceleration if is_moving else deceleration
	
	velocity = velocity.move_toward(desired_velocity, max_speed_change * delta)


func _dash():
	var move_dir = controller.get_move_direction()
	var dir = move_dir if move_dir.length() > 0.01 else Vector2.RIGHT.rotated(global_rotation)
	velocity = dir.normalized() * dash_speed


func _apply_soft_collision(delta: float):
	soft_collision.push_factor = velocity.length()
	
	if not _is_moving():
		velocity += soft_collision.get_push_vector() * delta
		
func _is_moving() -> bool:
	return velocity.length() > 0.01
