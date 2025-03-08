class_name ChargeState extends State
## Defines behavior for a charged action

#State
#signal change_state(new_state: State)
#var _entity: CharacterBody2D

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
