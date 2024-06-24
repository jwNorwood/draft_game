extends CanvasLayer

@export var time_manager:  Node
@onready var label = %TimeLabel

func _process(delta):
	if time_manager  == null:
		return
	var time_elapsed = time_manager.get_time_elapsed()
	label.text = format_time_to_string(time_elapsed)

func format_time_to_string(seconds: float):
	var minutes = floor(seconds / 60)
	var remaining_seconds = seconds - (minutes * 60)
	return str(minutes) + ":" + ("%02d" % floor(remaining_seconds))
