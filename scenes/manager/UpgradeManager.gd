extends Node

@export var tower_pool: Array[Tower]
@export var experience_manager: Node
@export var build_manager: Node
@export var upgrade_screen_scene: PackedScene

var current_upgrades = {}

func _ready():
	experience_manager.level_up.connect(on_level_up)
	
func on_level_up(current_level: int):
	var chosen_upgrade = tower_pool.pick_random()
	if chosen_upgrade == null:
		return
		
	var upgrade_screen_instance = upgrade_screen_scene.instantiate()
	add_child(upgrade_screen_instance)
	 #upgrades are broken, I need to comit the code to git
	upgrade_screen_instance.set_ability_upgrades(tower_pool as Array[Tower])
	upgrade_screen_instance.upgrade_selected.connect(on_upgrade_selected)
	
func apply_upgrade(upgrade: Tower):
	tower_pool = tower_pool.filter(func (tower: Tower): return tower.id != upgrade.id)
	build_manager.add_option(upgrade)
	
func on_upgrade_selected(upgrade: Tower):
	apply_upgrade(upgrade)
	
