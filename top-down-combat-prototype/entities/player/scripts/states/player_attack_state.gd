extends State
## Defines behavior [State] for an entity.
##
## Requires a [StateMachine] parent to manage [State] transitions.
## @experimental

@onready var player: PlayerController = $"../.."
@export var animation_player: AnimationPlayer
@export var attack_length: float = 5.0
@export var stamina_cost: float = 5.0
var _attack_timer: float = 0.0
var can_attack: bool = false
var attack_direction: Vector2

## Enter this [State].
func enter() -> void:
	if player.stamina_component.stamina >= stamina_cost:
		player.stamina_component.regenerates_stamina = false
		animation_player.play("attack")
		player.drain_stamina(5)
		attack_direction = get_local_mouse_position().normalized()
		_entity.velocity = attack_direction * 500
		can_attack = true

## Called every frame in entity's [StateMachine].
func process_behavior(delta: float) -> void:
	if _attack_timer <= attack_length and can_attack:
		_attack_timer += delta
		_entity.velocity = _entity.velocity.move_toward(Vector2.ZERO, 50)
		_entity.move_and_slide()
	else:
		change_state.emit("Idle")

## Exit this [State].
func exit() -> void:
	player.stamina_component.regenerates_stamina = true
	can_attack = false
	_attack_timer = 0.0
