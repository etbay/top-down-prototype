class_name ChargeState extends ActionState
## Defines behavior for a charged action

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D

#ActionState
#signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

var hold_length: float

## Enter this [ChargeState].
func enter() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable enter()")

## Called every frame in parent while [ChargeState] is active.
func process_behavior(delta: float) -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable process_behavior(delta: float)")

## Exit this [ChargeState].
func exit() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable exit()")
