extends Control

signal player_leave(idx)

onready var label := $VBoxContainer/Player
onready var ready_label := $VBoxContainer/Ready

var logger = Logger.new("PlayerSelect")

var player_idx: int setget _set_player_idx
var is_ready = false setget _set_ready

func _ready():
	reset()


func _set_ready(value: bool) -> void:
	is_ready = value
	ready_label.text = "Ready" if value else "Press <SPACE> to be ready"
	logger.debug("Set ready for player %s: %s" % [player_idx, is_ready])


func _set_player_idx(idx: int) -> void:
	player_idx = idx
	
	if idx != -1:
		label.text = "Player %s" % (idx + 1)
		ready_label.visible = true
	else:
		label.text = "Press <SPACE> to join"
		ready_label.visible = false
	
	logger.debug("Set player %s" % idx)

func set_player(idx: int) -> void:
	self.player_idx = idx
	self.is_ready = false
	Global.player_manager.get_player_input(idx).connect("just_released", self, "_on_input_released")


func reset() -> void:
	self.is_ready = false
	self.player_idx = -1


func _on_input_released(action: String):
	if action == "ui_accept":
		self.is_ready = true
	elif action == "ui_cancel":
		if is_ready:
			self.is_ready = false
		else:
			Global.player_manager.get_player_input(player_idx).disconnect("just_released", self, "_on_input_released")
			emit_signal("player_leave", player_idx)
