extends TabContainer
var selectedfile = ""


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var e = event as InputEventKey
		if event.is_pressed():
			if e.keycode == KEY_LEFT and Input.is_action_pressed("modifier"):
				current_tab = max(current_tab - 1, 0)
			elif e.keycode == KEY_RIGHT and Input.is_action_pressed("modifier"):
				current_tab = min(current_tab + 1, get_tab_count() - 1)
			elif e.keycode == KEY_N and Input.is_action_pressed("modifier"):
				var f = get_parent().get_node("filepreview").duplicate()
				add_child(f)
				f.name = "newfile (txt)"
				f.full_path = "newfiledontsavecorrectly"
				f.visible = true
			elif e.keycode == KEY_O and Input.is_action_pressed("modifier"):
				var getFile = FileDialog.new()
				getFile.title = "open file"
				getFile.file_mode = FileDialog.FILE_MODE_OPEN_FILE
				getFile.access = FileDialog.ACCESS_FILESYSTEM
				getFile.use_native_dialog = true
				getFile.file_selected.connect(func(path):
					var f = get_parent().get_node("filepreview").duplicate()
					add_child(f)
					f.name = path.get_basename().get_file() + " (" + path.get_extension() + ")"
					f.full_path = path
					var file = FileAccess.open(path, FileAccess.READ)
					f.get_node("CodeEdit").text = file.get_as_text()
					f.visible = true
				)
				getFile.popup()


func _on_tab_changed(tab: int) -> void:
	selectedfile = get_child(tab).name
	print("file changed " + selectedfile)
	DisplayServer.window_set_title("grade - " + selectedfile)
