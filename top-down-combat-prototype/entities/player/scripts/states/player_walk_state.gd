extends State
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

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
		change_state.emit("Idle")
	
	EntityPhysics.walk_toward(_entity, input_vector)
	
	if Input.is_action_just_pressed("main_attack"):
		change_state.emit("ChargeStateTest")

## Exit this [State].
func exit() -> void:
	is_active = false
