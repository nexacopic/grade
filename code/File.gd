extends Control
@export var full_path = ""
@export var type = "txt"


func _unhandled_input(event: InputEvent) -> void:
	if(!visible):
		return;
	type = full_path.get_extension()
	if event is InputEventKey and event.pressed:
		var e = event as InputEventKey
		if event.is_pressed():
			if e.keycode == KEY_S and Input.is_action_pressed("modifier"):
				save()
			if e.keycode == KEY_S and Input.is_action_pressed("modifier") and Input.is_action_pressed("shiftmod"):
				saveas()
			if e.keycode == KEY_X and Input.is_action_pressed("modifier"):
				save(false)
				queue_free()

func visible_to_real_filename(filename: String) -> String:
	var regex = RegEx.new()
	regex.compile(r"(.+)\s\((\w+)\)")
	
	var match = regex.search(filename)
	
	if match:
		var base_name = match.get_string(0)
		var extension = match.get_string(1)
		return base_name + "." + extension
	else:
		return filename
		
func real_to_visible_filename(filename: String) -> String:
	var splits = filename.split(".")
	if splits.size() == 2:
		return splits[0] + " (" + splits[1] + ")"
	else:
		return filename

func save(savease = true):
	var filename = full_path
	if(filename=="newfiledontsavecorrectly"):
		if(savease): saveas()
		return;
	
	DirAccess.remove_absolute(filename)
	var f = FileAccess.open(filename, FileAccess.WRITE)
	f.store_string($CodeEdit.text)
	name = filename.get_basename().get_file() + " (" + filename.get_extension() + ")"
	

func saveas():
	var getFile = FileDialog.new()
	getFile.title = "save as"
	getFile.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	getFile.access = FileDialog.ACCESS_FILESYSTEM
	getFile.use_native_dialog = true
	getFile.file_selected.connect(func(path):full_path = path; save())
	getFile.popup()


func _on_code_edit_text_changed() -> void:
	if("*" not in name):
		name += " *"
