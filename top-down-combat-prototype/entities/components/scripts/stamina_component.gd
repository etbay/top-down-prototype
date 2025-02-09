class_name StaminaComponent extends Node2D
## Attached to entities that consume stamina.

## Max stamina entity can hold.
@export var max_stamina: float
## Determines how fast entity regenerates stamina. [br]
## Will regenerate that amount every second.
@export var regeneration_amount: float
## Contains current stamina value.
var stamina: float
## Determines if entity can regenerate stamina.
var regenerates_stamina: bool = true

## Returns if stamina is empty.
var is_stamina_empty: bool:
	get:
		return stamina <= 0.0
## Returns if stamina is full.
var is_stamina_full: bool:
	get:
		return stamina >= max_stamina

func _ready() -> void:
	stamina = max_stamina

func _process(delta: float) -> void:
	if not is_stamina_full and regenerates_stamina:
		regenerate_stamina(delta)

## Regenerates stamina modified by [member regeneration_percent].
func regenerate_stamina(delta: float) -> void:
	if stamina < max_stamina:
		stamina += regeneration_amount * delta
		stamina = clampf(stamina, 0.0, max_stamina)

## Drains current stamina by [param drain_amount].
func drain_stamina(drain_amount: float) -> void:
	stamina -= drain_amount
	stamina = clampf(stamina, 0.0, max_stamina)

## Increases current stamina by [param gain_amount].
func gain_stamina(gain_amount: float) -> void:
	stamina += gain_amount
	stamina = clampf(stamina, 0.0, max_stamina)
