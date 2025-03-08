class_name WeaponData extends Resource

enum Weight
{
	LIGHT,
	MEDIUM,
	HEAVY
}

## Length of weapon attack in seconds. LIGHT (0.0-0.6), MEDIUM (0.6-1.7), HEAVY (1.7-3.0)
@export_range(0, 3, 0.05) var attack_length: float = 0.0
## Amount of stamina weapon attack drains. LIGHT (0-3), MEDIUM (3-6), HEAVY (6-10)
@export var stamina_drain: float = 0.0
## Weight class of weapon.
@export var weapon_weight: Weight = Weight.LIGHT
