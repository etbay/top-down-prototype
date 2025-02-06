extends CharacterBody2D
class_name PlayerController
## Controls player movement and input
##
## Detects input and switches state using state machine (not implemented)
## Need to move enemy detection to attack radius

const SPEED = 300.0
const ACCELERATION = 300.0
var enemies_nearby: Array[Enemy] = []

func _physics_process(delta: float) -> void:
	process_movement()

func process_movement() -> void:
	#rotate_player()
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_axis("move_left", "move_right")
	input_vector.y = Input.get_axis("move_up", "move_down")
	input_vector = input_vector.normalized()
	
	velocity = velocity.move_toward(input_vector * SPEED, ACCELERATION)
	
	if Input.is_action_just_pressed("main_attack"):
		var enemy = get_closest_enemy()
		if enemy:
			enemy.damage()
	
	if Input.is_action_just_pressed("print_debug"):
		#print_closest()
		pass
	
	move_and_slide()

func get_closest_enemy() -> Enemy:
	if not enemies_nearby.is_empty():
		#print("enemy nearby")
		var closest: Enemy = enemies_nearby[0]
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
		#print("no enemy nearby")
		return null

func _on_attack_radius_entered(body: Node2D) -> void:
	if body is Enemy:
		enemies_nearby.append(body as Enemy)

func _on_attack_radius_exited(body: Node2D) -> void:
	if body is Enemy:
		enemies_nearby.remove_at(enemies_nearby.find(body as Enemy))
