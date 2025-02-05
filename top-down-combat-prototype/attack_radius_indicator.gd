extends Sprite2D

@export var attack_radius: CollisionShape2D
@onready var sprite_2d: Sprite2D = $"../Sprite2D"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var length = attack_radius.shape.get_rect().size * 2.5
	var mouse_direction := (get_global_mouse_position() - sprite_2d.global_position).normalized()
	if Input.is_action_just_pressed("print_debug"):
		print(attack_radius.shape.get_rect().size)
	if (get_global_mouse_position() - sprite_2d.global_position).length() > length.x:
		self.global_position = sprite_2d.global_position + (length.x * mouse_direction)
	else:
		self.global_position = get_global_mouse_position()
