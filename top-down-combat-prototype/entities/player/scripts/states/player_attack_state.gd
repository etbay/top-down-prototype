extends ActionState

#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#var is_active: bool = false

#ActionState
#signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

@export var animation_player: AnimationPlayer
@export var action_length: float = 5.0
@export var stamina_cost: float = 5.0
var _action_timer: float = 0.0
var attack_direction: Vector2

## Enter player attack [State].
## Initiates attack if player has enough stamina.
func enter() -> void:
	attempting_action.emit(stamina_cost, action_length, process_action)

## Begins action if there is enough stamina.
func process_action() -> void:
	print("started attacking")
	is_active = true
	animation_player.play("attack")
	
	attack_direction = get_local_mouse_position().normalized()
	_entity.velocity = attack_direction * 500

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if is_active:
		if _action_timer <= action_length:
			_action_timer += delta
			_entity.velocity = _entity.velocity.move_toward(Vector2.ZERO, 50)
			_entity.move_and_slide()
			if Input.is_action_just_pressed("main_attack"):
				change_state.emit("AttackSelector")
		else:
			is_active = false
	else:
		change_state.emit("Idle")

## Exit this [State].
func exit() -> void:
	is_active = false
	_action_timer = 0.0
