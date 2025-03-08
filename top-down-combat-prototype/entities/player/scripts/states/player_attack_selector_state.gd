extends ChargeState
## Defines behavior for a charged action

#State
#signal change_state(new_state: State)
#var _entity: CharacterBody2D
#is_active = true

#ChargedState
#var hold_length: float

#Tracks what stage of attack it is in (1-3)

signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

@export var entity: CharacterBody2D

@export_group("Transition Set")
@export var light_attack_state: State
@export var medium_attack_state: State
@export var heavy_attack_state: State
var attack_states: Dictionary

func _ready() -> void:
	var child_nodes: Array[Node] = self.get_children()
	# Populate states dictionary
	for node in child_nodes:
		if node is State:
			node.connect("change_state", Callable(self, "transition_to_state"))
			if node is ActionState:
				node.connect("attempting_action", Callable(self, "try_action"))
			# Pass reference of entity to each state
			node._entity = self.entity
			attack_states[node.name] = node

func transition_to_state(new_state: State) -> void:
	change_state.emit(new_state)

func try_action(action_cost: float, action_length: float, process_action: Callable) -> void:
	attempting_action.emit(action_cost, action_length, process_action)

## Enter this [ChargeState].
func enter() -> void:
	is_active = true

## Called every frame in parent while [ChargeState] is active.
func process_behavior(delta: float) -> void:
	#var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#
	#if input_vector != Vector2.ZERO:
		#EntityPhysics.walk_toward(_entity, input_vector)
	#else:
		#EntityPhysics.apply_friction(_entity)
	process_input(delta)

func process_input(delta: float) -> void:
	if Input.is_action_pressed("main_attack"):
		hold_length += delta
		if hold_length >= 3:
			change_state.emit(heavy_attack_state)
			exit()
	elif hold_length > 0:
		if hold_length <= 1:
			change_state.emit(light_attack_state)
		elif hold_length <= 2:
			change_state.emit(medium_attack_state)
		else:
			change_state.emit(heavy_attack_state)
		exit()

## Exit this [ChargeState].
func exit() -> void:
	#print("Held for: " + str(hold_length) + " seconds")
	is_active = false
	hold_length = 0.0
