extends Node2D

export var player_scene: PackedScene

func _ready():
	for input in Global.player_manager.players:
		var player = player_scene.instance()
		player.set_input(input)
		add_child(player)
