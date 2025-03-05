class_name EntityPhysics extends Node2D

static func apply_friction(entity: Entity) -> void:
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.FRICTION)
	entity.move_and_slide()
