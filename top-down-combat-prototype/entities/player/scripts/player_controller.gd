class_name PlayerController extends CharacterBody2D
## Controls player movement and input
##
## Detects input and switches state using state machine (not implemented)
## Need to move enemy detection to attack radius

@export var player_sprite: Sprite2D
@export var state_machine: PlayerStateMachine

@export var stamina_bar: ProgressBar
@export var stamina_component: StaminaComponent
@export_category("Player Stats")

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_HIDDEN

func _physics_process(delta: float) -> void:
	face_mouse_direction()
	stamina_bar.value = stamina_component.stamina

func face_mouse_direction() -> void:
	if not state_machine.is_in_combat_state:
		# Looks at mouse if it is not absurdly close
		# Prevents spinning
		if (get_local_mouse_position() - Vector2(0,0)).length() > 4:
			var target_rotation = self.global_position.angle_to_point(get_global_mouse_position())
			player_sprite.rotation = lerp_angle(player_sprite.rotation, target_rotation - deg_to_rad(90), 0.5)

#func regenerate_stamina(delta: float) -> void:
	#if stamina < max_stamina:
		#stamina += stamina_regeneration * delta
		#stamina = clampf(stamina, 0.0, max_stamina)

func drain_stamina(amount: float) -> void:
	stamina_component.drain_stamina(amount)

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
