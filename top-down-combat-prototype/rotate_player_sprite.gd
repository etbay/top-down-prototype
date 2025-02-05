extends Node2D
## Rotates player sprite to face mouse position
##
## May want to change to click direction/animation -> walk direction
## Sprite2D offset must center sprite in hitbox

@export var object_rotation_degrees: int

func _physics_process(delta: float) -> void:
	if (get_local_mouse_position() - Vector2(0,0)).length() > 4:
		look_at(get_global_mouse_position())
		rotation += deg_to_rad(object_rotation_degrees)
