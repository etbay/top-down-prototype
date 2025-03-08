extends Camera2D

var zoom_amount: float = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	control_zoom()

func control_zoom() -> void:
	if Input.is_action_just_pressed("zoom_in"):
		zoom_in()
	if Input.is_action_just_pressed("zoom_out"):
		zoom_out()

func zoom_in() -> void:
	if zoom.x < 2 and zoom.y < 2:
		zoom.x += 0.1
		zoom.y += 0.1

func zoom_out() -> void:
	if zoom.x > 0.2 and zoom.y > 0.2:
		zoom.x -= 0.1
		zoom.y -= 0.1
