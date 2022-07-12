extends Control

export var next_scene: PackedScene

export var player_select: PackedScene

onready var player_manager: PlayerManager = Global.player_manager
onready var players_container := $Players

var logger = Logger.new("PlayerSelectMenu")

func _ready():
	for p in player_manager.max_players:
		var select = player_select.instance()
		players_container.add_child(select)
		select.connect("player_leave", self, "_on_player_leave")
	
	player_manager.connect("player_added", self, "_on_player_added")
	player_manager.connect("player_removed", self, "_on_player_removed")


func _unhandled_input(event):
	if event.is_action_pressed("ui_accept"):
		player_manager.add_player(event)
		
		if _are_all_players_ready():
			logger.debug("All players ready. Starting game...")
			get_tree().change_scene_to(next_scene)


func _on_player_added(player_idx: int) -> void:
	var select = players_container.get_child(player_idx)
	select.set_player(player_idx)


func _on_player_removed(player_idx: int) -> void:
	players_container.get_child(player_idx).reset()


func _on_player_leave(idx: int) -> void:
	player_manager.remove_player(idx)


func _are_all_players_ready() -> bool:
	var has_players = false
	for select in players_container.get_children():
		if select.player_idx != -1:
			if not select.is_ready:
				return false
			else:
				has_players = true
	return has_players
