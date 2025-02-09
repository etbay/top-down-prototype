class_name PlayerStateMachine extends StateMachine

## List of all combat [State] behaviors.
@export var combat_states: Array[State]
## Returns if [member entity] is in a combat [State]
var is_in_combat_state: bool:
	get:
		return combat_states.has(current_state)

func _ready() -> void:
	init(initial_state)

func _process(delta: float) -> void:
	self.process_state(delta)

## Initializes [StateMachine].
func init(initial_state: State) -> void:
	# Initialize and enter starting state
	if initial_state != null:
		current_state = initial_state
		current_state.enter()
	else:
		assert(false, "Initial state of " + entity.name + " not set in " + self.name)
	
	var child_nodes: Array[Node] = self.get_children()
	# Populate states dictionary
	for node in child_nodes:
		if node is State:
			node.connect("change_state", Callable(self, "transition_to_state"))
			# Pass reference of entity to each state
			node._entity = self.entity
			states[node.name] = node

## Processes [member current_state] behavior every frame.
func process_state(delta: float) -> void:
	current_state.process_behavior(delta)

## Transitions from [member current_state] to [param next_state].
func transition_to_state(next_state: String) -> void:
	if states.has(next_state):
		current_state.exit()
		current_state = states[next_state]
		current_state.enter()
	else:
		print("state not found, not changing")
