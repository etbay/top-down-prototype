class_name ActionState extends State
## Defines behavior [State] that consumes stamina for an entity.
##
## Requires a parent to manage [State] transitions.
## @experimental

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D

signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

## Enter this [ActionState].
func enter() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable enter()")

## Called every frame while [ActionState] is active.
func process_behavior(delta: float) -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable process_behavior()")

## Exit this [State].
func exit() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable exit()")
