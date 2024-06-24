extends Node

signal experience_collected(number: float)
signal currency_collected(number: float)
signal ability_upgrade_added(upgrade, current_upgrades: Dictionary)

func emit_experience_collected(number: float):
	experience_collected.emit(number)
	
func emit_ability_upgrade_added(upgrade, current_upgrades: Dictionary):
	ability_upgrade_added.emit(upgrade, current_upgrades)

func currency_collected_collected(number: float):
	currency_collected.emit(number)
