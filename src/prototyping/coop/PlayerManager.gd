class_name PlayerManager extends Node

signal player_added(player_idx)
signal player_removed(player_idx)

export var max_players = 4

var logger = Logger.new("PlayerManager")
var players = [] setget ,_get_players

func _ready():
	for i in range(0, max_players):
		players.append(null)

func remove_player(idx: int) -> void:
	var input = players[idx]
	if input:
		players[idx] = null
		emit_signal("player_removed", idx)
		logger.debug("Player %s removed: %s" % [idx, input.get_id()])


func add_player(event: InputEvent) -> void:
	var player_index = _first_available_index()
	if player_index == -1:
		logger.debug("Max player reached.")
		return

	var input = _create_input(event.device, _is_joypad_event(event))
	if _find_input_by_id(input.get_id()) != -1: return
	
	add_child(input)
	players[player_index] = input
	
	emit_signal("player_added", player_index)
	logger.debug("Player %s added: %s" % [player_index, input.get_id()])

func _first_available_index() -> int:
	for i in range(0, players.size()):
		if not players[i]:
			return i
	return -1

func _create_input(device: int, joypad: bool) -> PlayerInput:
	var input = PlayerInput.new()
	input.device_id = device
	input.joypad = joypad
	return input


func _is_joypad_event(event: InputEvent) -> bool:
	return event is InputEventJoypadButton or event is InputEventJoypadMotion


func _find_input_by_id(id: String) -> int:
	for i in range(0, players.size()):
		var input = players[i]
		if not input: continue
		
		if input.get_id() == id:
			return i
	return -1

func get_player_input(idx: int) -> PlayerInput:
	return players[idx]

func _get_players() -> Array:
	var result = []
	for p in players:
		if p: result.append(p)
	return result
