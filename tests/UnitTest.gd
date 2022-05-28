class_name UnitTest extends "res://addons/gut/test.gd"


func mouse_button_event(button: int, position: Vector2, pressed = true) -> InputEvent:
	var mouse = InputEventMouseButton.new()
	mouse.button_index = button
	mouse.pressed = pressed
	mouse.position = position
	mouse.global_position = position
	return mouse
