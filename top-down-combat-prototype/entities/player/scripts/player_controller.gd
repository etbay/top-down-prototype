class_name PlayerController extends Entity
## Controls player movement and input
##
## Detects input and switches state using state machine (not implemented)
## Need to move enemy detection to attack radius

#Entity
#var FRICTION: float = 50

@export var player_sprite: Sprite2D
@export var state_machine: PlayerStateMachine
@export var player_stats: PlayerStats
@export var stamina: StaminaComponent
@export var health: HealthComponent

func _ready() -> void:
	FRICTION = 20
	_verify_exports()
	_connect_to_signals()
	_initialize_components()

func _verify_exports() -> void:
	if state_machine == null:
		assert(false, "A StateMachine must be assigned to " + self.name + ".")
	if player_stats == null:
		assert(false, "A PlayerStats Resource must be assigned to " + self.name + ".")
	if stamina == null:
		assert(false, "A StaminaComponent must be assigned to " + self.name + ".")
	if health == null:
		assert(false, "A HealthComponent must be assigned to " + self.name + ".")

func _connect_to_signals() -> void:
	state_machine.connect("notify_action", Callable(self, "try_action"))
	health.connect("health_empty", Callable(self, "die"))

func _initialize_components() -> void:
	stamina.max_stamina = player_stats.max_stamina
	stamina.regeneration_amount = player_stats.stamina_regeneration_amount
	stamina.fill()
	
	health.max_health = player_stats.max_health
	health.fill()

func try_action(stamina_to_drain: float, pause_time: float, action: Callable, next_state: State) -> void:
	if stamina.try_drain_by(stamina_to_drain):
		stamina.pause_regeneration(pause_time)
		action.call(next_state)

func _physics_process(delta: float) -> void:
	face_mouse_direction()

func face_mouse_direction() -> void:
	if state_machine.current_state is not ActionState:
		# Looks at mouse if it is not absurdly close
		# Prevents spinning
		if (get_local_mouse_position() - Vector2(0,0)).length() > 4:
			var target_rotation = self.global_position.angle_to_point(get_global_mouse_position())
			player_sprite.rotation = lerp_angle(player_sprite.rotation, target_rotation - deg_to_rad(90), 0.3)

func die() -> void:
	print("man you dead")


#func regenerate_stamina(delta: float) -> void:
	#if stamina < max_stamina:
		#stamina += stamina_regeneration * delta
		#stamina = clampf(stamina, 0.0, max_stamina)

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
