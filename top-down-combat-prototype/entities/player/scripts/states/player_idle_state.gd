extends State

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#var is_active: bool = false

@export_group("Transition Set")
@export var walk_state: State
@export var attack_selector_state: State
@export var dodge_state: State

## Enter this [State].
func enter() -> void:
	is_active = true

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if is_active:
		EntityPhysics.apply_friction(_entity)
		
		process_input(delta)

## Processes player input and detects state changes.
func process_input(delta: float) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		change_state.emit(walk_state)
	if Input.is_action_just_pressed("main_attack"):
		change_state.emit(attack_selector_state)
	if Input.is_action_just_pressed("dodge"):
		change_state.emit(dodge_state)

## Exit this [State].
func exit() -> void:
	is_active = false
