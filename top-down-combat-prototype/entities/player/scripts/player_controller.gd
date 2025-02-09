class_name PlayerController extends CharacterBody2D
## Controls player movement and input
##
## Detects input and switches state using state machine (not implemented)
## Need to move enemy detection to attack radius

@export var player_sprite: Sprite2D
@export var state_machine: StateMachine

func _ready() -> void:
	print(state_machine)

func _physics_process(delta: float) -> void:
	if state_machine.current_state.name != "LightAttack":
		if (get_local_mouse_position() - Vector2(0,0)).length() > 4:
			player_sprite.look_at(get_global_mouse_position())
			player_sprite.rotation += deg_to_rad(-90)

#func attack() -> void:
	#var enemy: Enemy = get_closest_enemy()
	#if enemy:
		#velocity += (enemy.position - velocity).normalized() * 100
		#enemy.damage()

#func get_closest_enemy() -> Enemy:
	#if not enemies_nearby.is_empty():
		##print("enemy nearby")
		#var closest: Enemy = enemies_nearby[0]
		#var closest_length := (enemies_nearby[0].position - get_global_mouse_position()).length()
		#for enemy in enemies_nearby:
			##print(enemy)
			##print((enemy.position - self.position).length())
			#if (enemy.position - get_global_mouse_position()).length() < closest_length:
				#closest = enemy
				#closest_length = (enemy.position - get_global_mouse_position()).length()
		##print(closest)
		#return closest
	#else:
		##print("no enemy nearby")
		#return null

#func _on_attack_radius_entered(body: Node2D) -> void:
	#if body is Enemy:
		#enemies_nearby.append(body as Enemy)
#
#func _on_attack_radius_exited(body: Node2D) -> void:
	#if body is Enemy:
		#enemies_nearby.remove_at(enemies_nearby.find(body as Enemy))
