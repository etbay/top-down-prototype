class_name PlayerStats extends Resource
## Contains player stats.

signal max_stamina_changed()

## Max stamina player can hold.
@export var max_stamina: float
## Amount of stamina player regenerates per second.
@export var stamina_regeneration_amount: float
