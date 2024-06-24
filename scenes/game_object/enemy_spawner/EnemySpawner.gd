extends Node2D

@onready var timer = $Timer as Timer

var disabled: bool = false

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_timer_timeout():
	if (disabled):
		disabled = false
		
func disable():
	disabled = true
	
func isDisabled():
	return disabled
