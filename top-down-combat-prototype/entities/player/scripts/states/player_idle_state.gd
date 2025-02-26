extends State

## Amount to slow entity by every frame.
@export var FRICTION: float = 50

## Enter this [State].
func enter() -> void:
	pass

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	apply_friction()
	
	process_input(delta)

## Processes player input and detects state changes.
func process_input(delta: float) -> void:
	if Input.get_vector("move_left", "move_right", "move_up", "move_down") != Vector2.ZERO:
		change_state.emit("Walk")
	if Input.is_action_just_pressed("main_attack"):
		change_state.emit("ChargeStateTest")

## Exit this [State].
func exit() -> void:
	pass

## Apply friction to entity.
func apply_friction() -> void:
	_entity.velocity = _entity.velocity.move_toward(Vector2.ZERO, FRICTION)
	_entity.move_and_slide()
