class_name AttackState extends ActionState

#State
#signal change_state(new_state: State)
#var _entity: CharacterBody2D
#var is_active: bool = false

#ActionState
#signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

@export var animation_player: AnimationPlayer
@export var animation_name: String
var _action_timer: float = 0.0
var attack_direction: Vector2 = Vector2.ZERO

@export_group("Transition Set")
@export var attack_selector_state: State
@export var idle_state: State
var attack_stage: int

## Enter player attack [State].
## Initiates attack if player has enough stamina.
func enter() -> void:
	process_action()

## Begins action if there is enough stamina.
func process_action() -> void:
	is_active = true
	print("Attacking in stage ", attack_stage)
	animation_player.play(animation_name)
	
	_entity.velocity = attack_direction * 500

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if is_active:
		if _action_timer <= action_length:
			_action_timer += delta
			EntityPhysics.apply_friction(_entity)
		else:
			is_active = false
	else:
		change_state.emit(idle_state)

## Exit this [State].
func exit() -> void:
	is_active = false
	_action_timer = 0.0
