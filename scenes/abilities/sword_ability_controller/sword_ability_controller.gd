extends Node

const MAX_RANGE = 150
@export var sword_abilty: PackedScene
@export var base_wait_time: float
var damage = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	base_wait_time= $Timer.wait_time
	$Timer.timeout.connect(on_timer_timeout)
	
func distance_to_player(entity, player):
	return entity.global_position.distance_squared_to(player.global_position)

func on_timer_timeout():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	
	var enemies = get_tree().get_nodes_in_group("enemy") as Array
	var inRangeEnemies = enemies.filter(func(enemy: Node2D):
		return distance_to_player(enemy, player) < pow(MAX_RANGE, 2)
	)
	if inRangeEnemies.size() == 0:
		return

	inRangeEnemies.sort_custom(func(a: Node2D, b: Node2D):
		var a_distance = distance_to_player(a, player)
		var b_distance = distance_to_player(b, player)
		return a_distance < b_distance
	)
	
	var sword_instance = sword_abilty.instantiate() as SwordAbility
	player.get_parent().add_child(sword_instance)
	sword_instance.hitbox_component.damage = damage
	
	sword_instance.global_position = inRangeEnemies[0].global_position
	sword_instance.global_position += Vector2.RIGHT.rotated(randf_range(0,  TAU)) * 4
	var enemy_direction = inRangeEnemies[0].global_position - sword_instance.global_position
	
	sword_instance.rotation = enemy_direction.angle()

func on_ability_upgrade_added(upgrade, current_upgrades: Dictionary):
	if upgrade.id != "sword_rate":
		return
	
	var percent_reduction = current_upgrades["sword_rate"]["quantity"] * 0.1
	$Timer.wait_time = base_wait_time * (1 - percent_reduction)
	$Timer.start()
