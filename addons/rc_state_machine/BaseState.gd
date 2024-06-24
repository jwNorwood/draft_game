class_name RCBaseState
extends Node


## Called when the State Machine is ready and initialized. 
func on_init(_parent: Node2D):
	pass

## Called when the state enters
func on_enter() -> void:
	pass

## Called when the state exits
func on_exit() -> void:
	pass


## Equivalent to _input
func on_input(_event: InputEvent) -> RCBaseState:
	return null

## Equivalent to _unhandled_input
func on_unhandled_input(_event: InputEvent) -> RCBaseState:
	return null

## Equivalent to _unhandled_key_inpu
func on_unhandled_key_input(_event: InputEvent) -> RCBaseState:
	return null

## Equivalent to _process
func on_process(_delta: float) -> RCBaseState:
	return null

## Equivalent to _physics_process
func on_physics_process(_delta: float) -> RCBaseState:
	return null
