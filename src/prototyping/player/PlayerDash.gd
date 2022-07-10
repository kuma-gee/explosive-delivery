class_name PlayerDash extends Node

export var dash_speed := 1000

onready var player_move: PlayerMoveTop2D = get_parent()

var velocity = Vector2.ZERO

func _ready():
	yield(player_move, "ready")
	player_move.input.connect("just_released", self, "_on_just_released")

func _on_just_released(action):
	if action == "dash":
		player_move.body.move_and_slide(Vector2.RIGHT * dash_speed)

func _physics_process(delta):
	pass
