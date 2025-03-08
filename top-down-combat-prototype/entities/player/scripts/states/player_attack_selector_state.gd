extends ChargeState
## Defines behavior for a charged action

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#is_active = true

#ChargedState
#var hold_length: float

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
			change_state.emit("LightAttack")
		elif hold_length <= 2:
			change_state.emit("MediumAttack")
		else:
			change_state.emit("HeavyAttack")
	else:
		hold_length += delta

## Exit this [ChargeState].
func exit() -> void:
	#print("Held for: " + str(hold_length) + " seconds")
	is_active = false
	hold_length = 0.0
