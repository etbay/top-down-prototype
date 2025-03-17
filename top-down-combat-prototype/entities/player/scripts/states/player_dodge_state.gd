extends ActionState
#State
#signal change_state(new_state: String)
#var _entity: CharacterBody2D
#var is_active: bool = false

#ActionState
#signal attempting_action(action_cost: float, action_length: float, process_action: Callable)

@export_group("Transition Set")
@export var idle_state: State

var _action_timer: float = 0.0

## Enter this [ActionState].
func enter() -> void:
	attempting_action.emit(action_cost, action_length, process_action)

func process_action() -> void:
	var input_vector: Vector2 = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	is_active = true
	
	if input_vector != Vector2.ZERO:
		_entity.velocity = input_vector.normalized() * 300
	else:
		_entity.velocity = get_local_mouse_position().normalized() * 300

## Called every frame while [ActionState] is active.
func process_behavior(delta: float) -> void:
	if is_active:
		if _action_timer <= action_length:
			_action_timer += delta
			_entity.move_and_slide()
		else:
			is_active = false
	else:
		change_state.emit(idle_state)

## Exit this [State].
func exit() -> void:
	is_active = false
	_action_timer = 0.0
