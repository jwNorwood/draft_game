extends Node

signal experience_updated(current_experience: float, target_experience: float)
signal level_up(new_level: int)

var current_experience = 0 as float
var current_level = 1 as float
var target_experience = 5 as float
var target_experience_growth = 5 as float

func _ready():
	GameEvents.experience_collected.connect(on_experience_picked_up)

func increment_experience(number: float):
	current_experience = min(current_experience + number, target_experience)
	experience_updated.emit(current_experience, target_experience)
	if current_experience == target_experience:
		current_level += 1
		target_experience += target_experience_growth
		current_experience = 0
		experience_updated.emit(current_experience, target_experience)
		level_up.emit(current_level)
		
func on_experience_picked_up(number: float):
	increment_experience(number)
