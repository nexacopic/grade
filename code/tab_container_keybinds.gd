extends TabContainer
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var e = event as InputEventKey
		if event.is_pressed():
			if e.keycode == KEY_LEFT and Input.is_key_pressed(KEY_CTRL):
				current_tab = max(current_tab - 1, 0)
			elif e.keycode == KEY_RIGHT and Input.is_key_pressed(KEY_CTRL):
				current_tab = min(current_tab + 1, get_tab_count() - 1)
