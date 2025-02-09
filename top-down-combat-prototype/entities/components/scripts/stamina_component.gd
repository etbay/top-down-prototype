@icon("res://editor icons/stamina_component.png")
class_name StaminaComponent extends Node2D
## Attached to entities that consume [member stamina].

## Max [member stamina] entity can hold.
@export var max_stamina: float = 0.0
## Will regenerate [member stamina] by this amount every second.
@export var regeneration_amount: float = 0.0

## Emits signal when [member stamina] is changed.
signal stamina_changed(new_stamina: float)

## Contains current [member stamina] value.
var stamina: float:
	get:
		return stamina
	set(val):
		val = clampf(val, 0.0, max_stamina)
		stamina = val
		stamina_changed.emit(stamina)
## Determines if entity can regenerate [member stamina].
var regenerates_stamina: bool = true

## Returns true if [member stamina] is empty.
var is_stamina_empty: bool:
	get:
		return stamina <= 0.0
## Returns true if [member stamina] is full.
var is_stamina_full: bool:
	get:
		return stamina >= max_stamina

func _ready() -> void:
	stamina = max_stamina
	stamina_changed.emit(stamina)

func _process(delta: float) -> void:
	if not is_stamina_full and regenerates_stamina:
		regenerate_stamina(delta)
	print(stamina)

## Regenerates [member stamina] by [member regeneration_amount] every second.
func regenerate_stamina(delta: float) -> void:
	if stamina < max_stamina:
		stamina += regeneration_amount * delta

## Drains current [member stamina] by [param drain_amount].
func drain_stamina(drain_amount: float) -> void:
	stamina -= drain_amount

## Increases current [member stamina] by [param gain_amount].
func gain_stamina(gain_amount: float) -> void:
	stamina += gain_amount
