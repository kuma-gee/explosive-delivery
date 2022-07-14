extends Node2D

export var player_scene: PackedScene

onready var player := $Player
onready var input := $Player/PlayerInput

func _ready():
	player.set_input(input)
#	for input in Global.player_manager.players:
#		var player = player_scene.instance()
#		player.set_input(input)
#		add_child(player)
