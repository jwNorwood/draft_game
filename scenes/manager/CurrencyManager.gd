extends Node

@export var currency: int = 0

signal currency_updated(change: float)

func _ready():
	GameEvents.currency_collected.connect(on_currency_collected)

func get_currency():
	return currency
	
func on_currency_collected(ammount: int):
	currency += ammount
	currency_updated.emit()
	
# I may need to have a can spend check
func can_spend(amount: int):
	if (amount > currency):
		return false
	return true
	
func spend_currency(amount: int):
	if (can_spend(amount)):
		currency -= amount
		currency_updated.emit()
		return true
	else:
		return false

