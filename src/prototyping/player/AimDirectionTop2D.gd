class_name AimDirectionTop2D extends Node

export var controller_path: NodePath
onready var controller: PlayerController = get_node(controller_path)

onready var body: KinematicBody2D = get_parent()

func _process(_delta):
	var aim_dir = controller.get_look_direction(body)
	body.look_at(body.global_position + aim_dir)

