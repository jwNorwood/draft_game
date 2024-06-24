extends Node

signal upgrade_selected

@export var upgrade_card_scene: PackedScene
@onready var option_list: HBoxContainer = %CardContainer

func set_ability_upgrades(upgrades: Array[Tower]):
	get_tree().paused = true
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		option_list.add_child(card_instance)
		card_instance.set_option(upgrade)
		card_instance.selected.connect(on_option_selected.bind(upgrade))
		
func on_option_selected(item: Tower):
	upgrade_selected.emit(item)
	get_tree().paused = false
	self.queue_free()
