extends Sprite2D
## Controls location of attack radius indicator
##
## Determines location based on collision shape and center (sprite2D) [CHANGE CENTER]

@export var attack_radius: CollisionShape2D 	# CircleShape2D expected
@export var sprite_2d: Sprite2D

# Multiplied by max_dist to get accurate offset, 2.5 is exactly on circle collider perimeter
const DISTANCE_MULTIPLIER: float = 2
var max_dist_from_player: float

func _ready() -> void:
	max_dist_from_player = attack_radius.shape.get_rect().size.x * DISTANCE_MULTIPLIER

func _process(_delta: float) -> void:
	# Moves attack radius indicator to mouse position not beyond max_dist distance
	move_indicator()

func move_indicator():
	var mouse_distance := get_global_mouse_position() - sprite_2d.global_position
	var mouse_direction := mouse_distance.normalized()
	
	# If mouse is farther than radius, clamp with max_dist, otherwise use mouse position
	if mouse_distance.length() > max_dist_from_player:
		self.global_position = sprite_2d.global_position + (max_dist_from_player * mouse_direction)
	else:
		self.global_position = get_global_mouse_position()
