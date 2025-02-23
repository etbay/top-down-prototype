class_name Hurtbox extends Area2D
## Attached to entities that take damage.
##
## Notifies [HealthComponent] of damage by [Hitbox].

signal take_damage(damage: float)

func _on_area_entered(area: Area2D) -> void:
	if area is Hitbox:
		take_damage.emit(area.damage)
