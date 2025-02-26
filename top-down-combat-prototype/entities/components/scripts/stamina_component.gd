@icon("res://editor icons/stamina_component.png")
class_name StaminaComponent extends Node2D
## Attached to entities that consume [member stamina].
# May add the following functionalities:
#	Function that changes regeneration_amount for a time_in_seconds.

## Emits signal when [member stamina] is changed.
signal stamina_changed(new_stamina: float)

## Emits signal when [member max_stamina] is changed.
signal max_stamina_changed(new_max_stamina: float)

## Emits signal when [member stamina] is empty.
signal stamina_empty

## Emits signal when [member stamina] is full.
signal stamina_full

## Max [member stamina] entity can have.
@export var max_stamina: float = 0.0:
	get:
		return max_stamina
	set(val):
		# Ensure new value is not current max stamina
		if val != max_stamina:
			max_stamina = val
			# Ensure stamina is not greater than new max stamina
			if (_stamina > max_stamina):
				_stamina = max_stamina
			# Inform listeners of change
			max_stamina_changed.emit(max_stamina)

var _stamina: float:
	get:
		return _stamina
	set(val):
		# Ensure new value is not current stamina
		if val != _stamina:
			_stamina = clampf(val, 0.0, max_stamina)
			# Inform listeners of change
			stamina_changed.emit(_stamina)
		# Inform listeners if stamina is empty or full
		if _stamina <= 0:
			stamina_empty.emit()
		elif _stamina >= max_stamina:
			stamina_full.emit()

## Will regenerate [member stamina] by this amount every second.
@export var regeneration_amount: float = 0.0

# Returns true if stamina is empty.
var _is_stamina_empty: bool:
	get:
		return _stamina <= 0.0

# Returns true if stamina is full.
var _is_stamina_full: bool:
	get:
		return _stamina >= max_stamina

# Returns true if stamina is paused, enabled and disabled in pause_stamina_regeneration.
var _regen_paused: bool = false

func _ready() -> void:
	_stamina = max_stamina
	stamina_changed.emit(_stamina)

func _process(delta: float) -> void:
	_regenerate_stamina(delta)

# Regenerates stamina by regeneration_amount every second.
func _regenerate_stamina(delta: float) -> void:
	if not _regen_paused and not _is_stamina_full and _stamina < max_stamina:
		_stamina += regeneration_amount * delta

## Attempts to drain current [member stamina] by [param drain_amount].
## Returns true if successful.
func try_drain_by(drain_amount: float) -> bool:
	if (_stamina >= drain_amount):
		_stamina -= drain_amount
		return true
	else:
		return false

## Completely drains [member stamina].
func empty() -> void:
	_stamina = 0.0

## Increases current [member stamina] by [param increase_amount].
func increase_by(increase_amount: float) -> void:
	_stamina += increase_amount

## Completely fills [member stamina].
func fill() -> void:
	_stamina = max_stamina

## Pauses [member stamina] regeneration for [param time_in_seconds].
func pause_regeneration(time_in_seconds: float) -> void:
	_regen_paused = true
	await get_tree().create_timer(time_in_seconds).timeout
	_regen_paused = false
