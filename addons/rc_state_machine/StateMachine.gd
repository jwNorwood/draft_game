extends Node
class_name RCStateMachine

## The Name of the state to start with.
@export var starting_state_name : String

## The file location to load the state scripts. Scripts with filename starting with _ (underscore) will not be loaded.
@export_dir var state_locations : String


## The current state of the state machine.
var current_state: RCBaseState

## Dictionary holding the reference to the node states
var _states : Dictionary

func _ready() -> void:
	_init(get_parent())


## Changes the current state to the new state. DO NOT CALL EXPLICITLY!
func change_state(new_state: RCBaseState) -> void:
	if current_state:
		current_state.on_exit()

	current_state = new_state
	current_state.on_enter()

## Initializes the State Machine. By default uses the direct parent.
func _init(parent: Node2D) -> void:
	assert(state_locations != null, "state_locations is not assigned!")
	_load_states()

	for child in get_children():
		if(child is RCBaseState):
			for state in _states.keys():
				child.set(state, _states[state])
			child.on_init(parent)

	var starting_state = _states[starting_state_name]

	# Initialize with a default state of idle
	change_state(starting_state)



## Load the _states in the provided folder. Uses the file name in snake_case to add them into the _states dictionary. Ignores files starting with underscore.
func _load_states() -> void:
	var dir = DirAccess.open(state_locations)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				continue
			if file_name.ends_with(".gd") and not file_name.find("_") != 0:
				var state := load(state_locations + "/" + file_name)
				var n := Node2D.new()
				n.name = file_name.trim_suffix(".gd").to_snake_case()
				n.set_script(state)
				add_child(n)
				_states[file_name.trim_suffix(".gd").to_snake_case()] = n
			file_name = dir.get_next()
		dir.list_dir_end()


func _unhandled_input(event: InputEvent) -> void:
	var new_state = current_state.on_unhandled_input(event)
	if new_state:
		change_state(new_state)
	
func _physics_process(delta: float) -> void:
	var new_state = current_state.on_physics_process(delta)
	if new_state:
		change_state(new_state)

func _input(event: InputEvent) -> void:
	var new_state = current_state.on_input(event)
	if new_state:
		change_state(new_state)

func _process(delta: float) -> void:
	var new_state = current_state.on_process(delta)
	if new_state:
		change_state(new_state)

