class_name HealthComponent extends Node2D
## Attached to entities that have [member health].

## Emits signal when [member health] is changed.
signal health_changed(new_health: float)

## Emits signal when [member max_health] is changed.
signal max_health_changed(new_max_health: float)

## Emits signal when [member health] is empty.
signal health_empty

## Emits signal when [member health] is full.
signal health_full

## Max [member stamina] that entity can have.
@export var max_health: float = 0.0:
	get:
		return max_health
	set(val):
		if val != max_health:
			max_health = val
			if _health > max_health:
				_health = max_health
			max_health_changed.emit(max_health)

var _health: float = 0.0:
	get:
		return _health
	set(val):
		if val != _health:
			_health = clampf(val, 0, max_health)
			health_changed.emit(_health)
		if _health <= 0:
			health_empty.emit()
		if _health >= max_health:
			health_full.emit()

## Determines if entity will passively regenerate [member health].
@export var regenerates_health: bool

## Will regenerate [member health] by this amount every second if [member regenerates_health] is true.
@export var regeneration_amount: float

## Reference to child [Hurtbox] component.
@export var hurtbox: Hurtbox

var _is_health_empty: bool:
	get:
		return _health <= 0.0

var _is_health_full: bool:
	get:
		return _health >= max_health

func _ready() -> void:
	hurtbox.connect("take_damage", Callable(self, "drain_by"))
	_health = max_health
	health_changed.emit(_health)

func _process(delta: float) -> void:
	if regenerates_health:
		_regenerate_health(delta)

func _regenerate_health(delta: float) -> void:
	if not _is_health_full and _health < max_health:
		_health += regeneration_amount * delta

## Drains [member health] by [param drain_amount]
func drain_by(drain_amount: float) -> bool:
	if (_health >= drain_amount):
		_health -= drain_amount
		return true
	else:
		return false

## Completely drains [member health].
func empty() -> void:
	_health = 0.0

## Increases [member health] by [param increase_amount].
func increase_by(increase_amount: float) -> void:
	_health += increase_amount

## Completely fills [member health].
func fill() -> void:
	_health = max_health
