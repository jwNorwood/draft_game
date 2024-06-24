extends Node

@export_range(0,1) var drop_percent: float = 0.5
@export  var experience: PackedScene
@export var health_component: Node

func _ready():
	health_component.died.connect(on_died)
	
func on_died():
	if experience == null:
		return
		
	if not owner is Node2D:
		return
		
	if randf() > drop_percent:
		return
	
	var spawn_position = (owner as Node2D).global_position
	var experience_drop = experience.instantiate() as Node2D
	owner.get_parent().add_child(experience_drop)
	experience_drop.global_position = spawn_position
	
