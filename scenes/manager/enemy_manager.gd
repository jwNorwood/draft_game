extends Node

@export var enemy_scene: PackedScene

const SPAWN_RADIUS = 330
var enemy_queue: Array = []

func _ready():
	$Timer.timeout.connect(on_timer_timeout)
	
func on_timer_timeout():
	spawn_enemy()

func spawn_enemy():
	var spawn_position = get_spawn_position()
	if spawn_position == null:
		return	
	var enemy = enemy_scene.instantiate() as CharacterBody2D
	get_parent().add_child(enemy)
	enemy.global_position = spawn_position

func get_spawn_position():
	var spawn_points = get_tree().get_nodes_in_group("enemy_spawner")
	var active_spawn_points = spawn_points.filter(func(x): return x.isDisabled() == false)
	if active_spawn_points.size() == 0:
		return null
	var random_active_spawn_point = active_spawn_points[randi() % active_spawn_points.size()]
	random_active_spawn_point.disable()
	return random_active_spawn_point.global_position
