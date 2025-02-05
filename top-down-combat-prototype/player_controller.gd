extends CharacterBody2D


const SPEED = 300.0
const ACCELERATION = 300.0
var enemies_nearby: Array[CharacterBody2D] = []

func _physics_process(delta: float) -> void:
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	input_vector = input_vector.normalized()
	
	velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	
	if Input.is_action_just_pressed("main_attack"):
		var enemy = get_closest_enemy()
		if enemy:
			enemy.queue_free()
	
	if Input.is_action_just_pressed("print_debug"):
		#print_closest()
		pass
	
	move_and_slide()

func get_closest_enemy() -> CharacterBody2D:
	if not enemies_nearby.is_empty():
		print("enemy nearby")
		var closest: CharacterBody2D = enemies_nearby[0]
		var closest_length := (enemies_nearby[0].position - get_global_mouse_position()).length()
		for enemy in enemies_nearby:
			#print(enemy)
			#print((enemy.position - self.position).length())
			if (enemy.position - get_global_mouse_position()).length() < closest_length:
				closest = enemy
				closest_length = (enemy.position - get_global_mouse_position()).length()
		#print(closest)
		return closest
	else:
		print("no enemy nearby")
		return null

func _on_attack_radius_entered(body: Node2D) -> void:
	if body is CharacterBody2D and body != self:
		enemies_nearby.append(body as CharacterBody2D)

func _on_attack_radius_exited(body: Node2D) -> void:
	if body is CharacterBody2D and body != self:
		enemies_nearby.remove_at(enemies_nearby.find(body as CharacterBody2D))
