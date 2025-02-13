class_name ActionState extends State
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

signal attempting_action(stamina_to_consume: float, time_to_pause_stamina_regen: float, process_action: Callable)

@export var animation_player: AnimationPlayer
@export var action_length: float = 5.0
@export var stamina_cost: float = 5.0
var _action_timer: float = 0.0
var can_perform_action: bool = false
var attack_direction: Vector2

## Enter player attack [State].
## Initiates attack if player has enough stamina.
func enter() -> void:
	attempting_action.emit(stamina_cost, action_length, process_action)

## Begins action if there is enough stamina.
func process_action() -> void:
	animation_player.play("attack")
	
	attack_direction = get_local_mouse_position().normalized()
	_entity.velocity = attack_direction * 500
	can_perform_action = true

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if _action_timer <= action_length and can_perform_action:
		_action_timer += delta
		_entity.velocity = _entity.velocity.move_toward(Vector2.ZERO, 50)
		_entity.move_and_slide()
	else:
		change_state.emit("Idle")

## Exit this [State].
func exit() -> void:
	can_perform_action = false
	_action_timer = 0.0
