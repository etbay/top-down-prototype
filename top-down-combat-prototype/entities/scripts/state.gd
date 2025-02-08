extends Node
class_name State

signal change_state(new_state: String)

# Transition from previous state to current state
func enter():
	pass

# Called every frame in state machine
func process():
	pass

# Detects input that allows for transition
# Call at the end of process
func detect_transition():
	pass

# Transition from current state to next state
func exit():
	pass
