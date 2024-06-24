extends Area2D

signal selected
var hasTower: bool = false

func _ready():
	pass

func _on_input_event(viewport, event, shape_idx):
	if event.is_action_pressed("left_click") && !hasTower:
		print("clicked build select")
		hasTower = true
		selected.emit()
