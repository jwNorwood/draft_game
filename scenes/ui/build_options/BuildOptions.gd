extends Node

@onready var option_list:  HBoxContainer = %OptionList

@export var upgrade_card_scene: PackedScene
@export var currency_manager: Node
@export var build_manager: Node
@export var build_preview: PackedScene
@export var tower: PackedScene

func _ready():
	set_ability_upgrades(build_manager.get_options())
	build_manager.option_added.connect(on_update_option)
	print("tower? ", tower)
	
func on_update_option(new):
	set_ability_upgrades([new])
	
func set_ability_upgrades(upgrades: Array[Tower]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		option_list.add_child(card_instance)
		card_instance.set_option(upgrade)
		card_instance.selected.connect(on_option_selected.bind(upgrade))
		
func on_option_selected(upgrade):
	var preview = build_preview.instantiate()
	preview.set_item(upgrade)
	build_manager.add_child(preview)
	preview.build.connect(on_build)

func on_build(upgrade, location, preview):
	if currency_manager.spend_currency(upgrade.cost):
		# add tower to the level at the location
		var tower = tower.instantiate()
		tower.buildTower(upgrade, location)
		build_manager.add_child(tower)
		# this should be like the level or something
		preview.queue_free()
	else:
		print("You cannot build here =(")
