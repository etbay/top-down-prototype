class_name Health_Component extends Node

signal health_changed(new_health: float)
signal max_health_changed(new_max_health: float)
signal health_empty
signal health_full

@export var max_health: float = 0.0:
	get:
		return max_health
	set(val):
		if val != max_health:
			if _health > max_health:
				_health = max_health
			max_health_changed.emit(max_health)

@export var _health: float = 0.0:
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

@export var regenerates_health: bool

@export var regeneration_amount: float

func try_drain_by(drain_amount: float) -> bool:
	if (_health >= drain_amount):
		_health -= drain_amount
		return true
	else:
		return false

func empty() -> void:
	_health = 0.0

func increase_by(increase_amount: float) -> void:
	_health += increase_amount

## Completely fills [member stamina].
func fill() -> void:
	_health = max_health
