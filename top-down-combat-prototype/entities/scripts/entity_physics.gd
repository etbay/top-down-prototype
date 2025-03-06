class_name EntityPhysics extends Node2D

static func apply_friction(entity: Entity) -> void:
	entity.velocity = entity.velocity.move_toward(Vector2.ZERO, entity.FRICTION)
	entity.move_and_slide()
	
static func walk_toward(entity: Entity, direction: Vector2) -> void:
	entity.velocity = entity.velocity.move_toward(direction * entity.MOVE_SPEED, 100)
	entity.move_and_slide()
