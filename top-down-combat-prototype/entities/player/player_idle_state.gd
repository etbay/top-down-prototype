extends State

# Transition from previous state to current state
func enter():
	pass

# Called every frame in state machine
func process():
	# Apply friction to player
	
	detect_transition()

# Can transition to:
# Move
# Attack
# Dodge
# Parry
func detect_transition():
	
	pass

# Transition from current state to next state
func exit():
	pass
