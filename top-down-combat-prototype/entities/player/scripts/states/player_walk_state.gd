extends State
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

@export var WALK_SPEED: float = 300.0
@export var WALK_ACCELERATION: float = 300.0

## Enter this [State].
func enter() -> void:
	pass

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	process_input(delta)

## Processes player input and detects state changes.
func process_input(delta: float) -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if input_vector == Vector2.ZERO:
		change_state.emit("Idle")
	
	_entity.velocity = _entity.velocity.move_toward(input_vector * WALK_SPEED, 100)
	
	_entity.move_and_slide()
	
	if Input.is_action_just_pressed("main_attack"):
		change_state.emit("LightAttack")

## Exit this [State].
func exit() -> void:
	pass
