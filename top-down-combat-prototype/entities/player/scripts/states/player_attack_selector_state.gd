extends ChargeState
## Defines behavior for a charged action

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#is_active = true

#ChargedState
#var hold_length: float

@export_group("Transition Set")
@export var light_attack_state: State
@export var medium_attack_state: State
@export var heavy_attack_state: State

## Enter this [ChargeState].
func enter() -> void:
	is_active = true

## Called every frame in parent while [ChargeState] is active.
func process_behavior(delta: float) -> void:
	if is_active:
		var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		if input_vector != Vector2.ZERO:
			EntityPhysics.walk_toward(_entity, input_vector)
		else:
			EntityPhysics.apply_friction(_entity)
		process_input(delta)

func process_input(delta: float) -> void:
	if Input.is_action_just_released("main_attack"):
		if hold_length <= 1:
			change_state.emit(light_attack_state)
		elif hold_length <= 2:
			change_state.emit(medium_attack_state)
		else:
			change_state.emit(heavy_attack_state)
	else:
		hold_length += delta

## Exit this [ChargeState].
func exit() -> void:
	#print("Held for: " + str(hold_length) + " seconds")
	is_active = false
	hold_length = 0.0
