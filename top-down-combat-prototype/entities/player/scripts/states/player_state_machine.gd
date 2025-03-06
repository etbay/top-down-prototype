class_name PlayerStateMachine extends StateMachine
## Manages player states, action states, and state queue

#@export var entity: CharacterBody2D = null
#@export var initial_state: State = null
#var current_state: State
#var states: Dictionary

signal notify_action(stamina: float, pause_time: float, action: Callable)

## States in line to be performed next. Capped at [member _max_states_queued].
var action_state_queue: Array[String]
var _max_states_queued: int = 3

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
			if node is ActionState:
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

## Transitions from [member current_state] to [param next_state].
func transition_to_state(next_state: String) -> void:
	#print("transitioning from " + current_state.name + " to " + next_state)
	if current_state is ActionState and states[next_state] is ActionState:
		action_state_queue.append(next_state)
	elif states.has(next_state):
		if not action_state_queue.is_empty():
			next_state = action_state_queue.pop_front()
		_change_current_state(next_state)
	else:
		print("state not found, not changing")

func _change_current_state(next_state: String) -> void:
	current_state.exit()
	current_state = states[next_state]
	current_state.enter()
