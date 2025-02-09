extends State
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

@export var attack_length: float = 5.0
var _attack_timer: float = 0.0

## Enter this [State].
func enter() -> void:
	_entity.velocity = Vector2.ZERO

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	print(_attack_timer)
	if _attack_timer <= attack_length:
		_attack_timer += delta
	else:
		change_state.emit("Idle")

## Exit this [State].
func exit() -> void:
	_attack_timer = 0.0
