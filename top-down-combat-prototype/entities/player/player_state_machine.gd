extends Node
class_name PlayerStateMachine

@export var initial_state: State
var current_state: State

func _ready() -> void:
	current_state = initial_state

func _process(delta: float) -> void:
	current_state.process()
