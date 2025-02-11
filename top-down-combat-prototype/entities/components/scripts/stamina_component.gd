@icon("res://editor icons/stamina_component.png")
class_name StaminaComponent extends Node
## Attached to entities that consume [member stamina].
# May add the following functionalities:
#	Function that changes regeneration_amount for a time_in_seconds
#	Bool that determines if stamina increases in regeneration_amount over time

## Emits signal when [member stamina] is changed.
signal stamina_changed(new_stamina: float)
## Emits signal when [member max_stamina] is changed.
signal max_stamina_changed(new_max_stamina: float)
## Emits signal when [member stamina] is empty.
signal stamina_empty
## Emits signal when [member stamina] is full.
signal stamina_full

## Max [member stamina] entity can hold.
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
## Contains current [member stamina] value.
var _stamina: float:
	get:
		return _stamina
	set(val):
		if val != _stamina:
			val = clampf(val, 0.0, max_stamina)
			_stamina = val
			stamina_changed.emit(_stamina)
		if _stamina <= 0:
			stamina_empty.emit()
		elif _stamina >= max_stamina:
			stamina_full.emit()

## Will regenerate [member stamina] by this amount every second.
@export var regeneration_amount: float = 0.0

## Returns true if [member stamina] is empty.
var is_stamina_empty: bool:
	get:
		return _stamina <= 0.0
## Returns true if [member stamina] is full.
var is_stamina_full: bool:
	get:
		return _stamina >= max_stamina
# Returns true if stamina is paused, enabled and disabled in pause_stamina_regeneration
var _regen_paused: bool = false


func _ready() -> void:
	_stamina = max_stamina
	stamina_changed.emit(_stamina)

func _process(delta: float) -> void:
	_regenerate_stamina(delta)

# Regenerates stamina by regeneration_amount every second.
func _regenerate_stamina(delta: float) -> void:
	if not _regen_paused and not is_stamina_full and _stamina < max_stamina:
		_stamina += regeneration_amount * delta

## Drains current [member stamina] by [param drain_amount].
func drain_by(drain_amount: float) -> void:
	_stamina -= drain_amount

## Increases current [member stamina] by [param gain_amount].
func gain_by(gain_amount: float) -> void:
	_stamina += gain_amount

## Returns true if [member stamina] is at least [param stamina_amount].
func has_at_least(stamina_amount: float) -> bool:
	return _stamina >= stamina_amount

## Pauses [member stamina] regeneration for [param time_in_seconds].
func pause_stamina_regeneration(time_in_seconds: float) -> void:
	_regen_paused = true
	await get_tree().create_timer(time_in_seconds).timeout
	_regen_paused = false
