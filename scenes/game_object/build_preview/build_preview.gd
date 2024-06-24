extends Sprite2D

var item: Tower
signal build

func _ready():
	pass

func build_item():
	build.emit(self.item, get_global_mouse_position(), self)

func set_item(new_item):
	print("new_item", new_item)
	self.item = new_item
	#self.texture = default_texture

func _input(event):
	if event.is_action_pressed("left_click"):
		build_item()
	elif event is InputEventMouseMotion:
		self.position = get_global_mouse_position()
