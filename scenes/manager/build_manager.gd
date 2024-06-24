extends Node

signal money_updated(current_money: float, target_money: float)
signal option_added

@export var build_options: Array[Tower]
@export var build_screen_scene: PackedScene

var money = 0 as float

func _ready():
	pass
	
func get_options():
	return build_options
	
func add_option(new: Tower):
	build_options.push_back(new)
	option_added.emit(new)

func increment_experience(number: float):
	money_updated.emit(money, money + number)
	
func on_money_picked_up(number: float):
	increment_experience(number)

func build_item(item, location):
	print("build Item?")
	var cost = item.cost
	if (cost > money):
		return
	money -= cost
	# location.add_tower(item)
	# exit select
	pass
