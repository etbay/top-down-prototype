extends State

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#var is_active: bool = false

@export_group("Transition Set")
@export var idle_state: State
@export var attack_selector_state: State
@export var dodge_state: State

## Enter this [State].
func enter() -> void:
	is_active = true

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if is_active:
		process_input(delta)

## Processes player input and detects state changes.
func process_input(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector == Vector2.ZERO:
		change_state.emit(idle_state)
	
	EntityPhysics.walk_toward(_entity, input_vector)
	
	if Input.is_action_just_pressed("main_attack"):
		change_state.emit(attack_selector_state)
	if Input.is_action_just_pressed("dodge"):
		change_state.emit(dodge_state)

## Exit this [State].
func exit() -> void:
	is_active = false
