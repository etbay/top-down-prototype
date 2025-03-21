class_name PlayerStateMachine extends StateMachine
## Manages player states, action states, and state queue

#@export var entity: CharacterBody2D = null
#@export var initial_state: State = null
#var current_state: State
#var states: Dictionary

signal notify_action(stamina: float, pause_time: float, action: Callable, next_state: State)

## States in line to be performed next. Capped at [member _max_states_queued].
var action_state_queue: Array[ActionState]
var _max_states_queued: int = 3

@export var attack_selector_state: ChargeState

func _ready() -> void:
	populate_states(initial_state)

func _process(delta: float) -> void:
	self.process_state(delta)

## Initializes [StateMachine].
func populate_states(initial_state: State) -> void:
	# Initialize and enter starting state
	if initial_state != null:
		current_state = initial_state
		current_state.enter()
	else:
		# Throw error if initial state is null
		assert(false, "Initial state of " + entity.name + " not set in " + self.name)
	
	var child_nodes: Array[Node] = self.get_children()
	# Populate states dictionary
	for node in child_nodes:
		if node is State:
			node.connect("change_state", Callable(self, "transition_to_state"))
			if node is ActionState or node is ChargeState:
				node.connect("attempting_action", Callable(self, "try_action"))
			# Pass reference of entity to each state
			node._entity = self.entity
			states[node.name] = node
	
	#for state in states:
	#	print(state)

func try_action(stamina: float, pause_time: float, action: Callable) -> void:
	notify_action.emit(stamina, pause_time, action)

## Processes [member current_state] behavior every frame.
func process_state(delta: float) -> void:
	current_state.process_behavior(delta)
	attack_selector_state.process_behavior(delta)

## Transitions from [member current_state] to [param next_state].
func transition_to_state(next_state: State) -> void:
	#print("transitioning from " + current_state.name + " to " + next_state)
	if current_state is ActionState and next_state is ActionState:
		if action_state_queue.size() < 1:
			action_state_queue.append(next_state)
	elif next_state is not ChargeState:
		if not action_state_queue.is_empty():
			next_state = action_state_queue.pop_front()
		_change_current_state(next_state)

func _change_current_state(next_state: State) -> void:
	current_state.exit()
	# Checks if player has enough stamina before entering state
	if next_state is ActionState:
		notify_action.emit(next_state.action_cost, next_state.action_length, Callable(self, "_change_state"), next_state)
	else:
		_change_state(next_state)

func _change_state(next_state: State) -> void:
	current_state = next_state
	current_state.enter()
