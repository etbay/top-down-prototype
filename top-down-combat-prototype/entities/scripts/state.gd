class_name State extends Node2D
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

## Notifies [StateMachine] of what [State] to transition to.
signal change_state(new_state: State)
var _entity: CharacterBody2D
var is_active: bool = false

## Enter this [State].
func enter() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable enter()")

## Called every frame while [State] is active.
func process_behavior(delta: float) -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable process_behavior(delta: float)")

## Exit this [State].
func exit() -> void:
	assert(false, self.name + " state of " + self._entity.name + " does not implement Callable exit()")
