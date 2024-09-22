extends Control

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var e = event as InputEventKey
		if event.is_pressed():
			if e.keycode == KEY_S and Input.is_key_pressed(KEY_CTRL):
				# TODO: Save
				pass
			
