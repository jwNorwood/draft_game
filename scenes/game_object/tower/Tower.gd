extends CharacterBody2D

@onready var sprite: Sprite2D = $Sprite 
@onready var timer = $Timer as Timer

var tower: Dictionary = {
	"health": 100,
	"attack": {
		"speed": 1,
		"damage": 10,
		"range": 100,
	},
	"cost": 1,
	"id": 0,
	"description": "This is the default description",
}

var disabled: bool

func _ready():
	$Timer.timeout.connect(on_timer_timeout)

func buildTower(item: Tower, location):
	# standardize size
	# sprite.texture = tower.texture
	self.global_position = location
	# I will need a workaround for items that dont have a perm stucture
	# add this node to the scene after it is built
	# set up the attack timer if there is an attack speed
	pass

func upgradeTower(upgrade):
	pass

func onTowerClicked():
	# display a modal with info on the tower
	# modal has delete and upgrade actions
	pass

func on_timer_timeout():
	var target = getTarget()
	# attack(target)
	pass

# COMBAT
func attack(target):
	# then do an attack
	pass

func getTarget():
	var enemies = get_tree().get_nodes_in_group("enemy") as Array
	var inRangeEnemies = enemies.filter(func(enemy: Node2D):
		return distance_to_tower(enemy, tower) < pow(tower.attack.range, 2)
	)
	if inRangeEnemies.size() == 0:
		return null

	inRangeEnemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = distance_to_tower(a, tower)
		var b_distance = distance_to_tower(b, tower)
		return a_distance < b_distance
	)
	if inRangeEnemies.length > 0:
		return inRangeEnemies[0]
	else:
		return null
	
func distance_to_tower(entity, tower):
	return entity.global_position.distance_squared_to(tower.global_position)
