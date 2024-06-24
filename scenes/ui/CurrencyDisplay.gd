extends CanvasLayer

@export var currency_manager: Node
@onready var amount_label = %Amount

func _ready():
	amount_label.text = str(currency_manager.get_currency())
	currency_manager.currency_updated.connect(on_currency_updated)
	
func on_currency_updated():
	amount_label.text = str(currency_manager.get_currency())
