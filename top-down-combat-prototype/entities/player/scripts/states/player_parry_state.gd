extends ActionState
#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#var is_active: bool = false

#ActionState
#signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

## Enter this [ActionState].
func enter() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable enter()")

## Called every frame while [ActionState] is active.
func process_behavior(delta: float) -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable process_behavior()")

## Exit this [State].
func exit() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable exit()")
