extends CodeEdit
func _process(delta: float) -> void:
	if(Input.is_action_just_pressed("modifier")):
		release_focus()
	if(Input.is_action_just_released("modifier")):
		grab_focus()
