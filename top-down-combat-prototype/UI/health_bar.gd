extends ProgressBar

@export var health_component: HealthComponent

func _ready() -> void:
	# Listen for changes
	health_component.connect("health_changed", Callable(self, "update_health_bar"))
	health_component.connect("max_health_changed", Callable(self, "update_health_bar_size"))
	
	# Initialize bar
	self.max_value = health_component.max_health
	self.custom_minimum_size.x = health_component.max_health * 10

## Updates [StaminaBar] value when [StaminaComponent] stamina is changed.
func update_health_bar(health: float) -> void:
	self.value = health

## Updates [StaminaBar] size when [StaminaComponent] max stamina is changed.
func update_health_bar_size(max_health: float) -> void:
	self.max_value = max_health
	self.custom_minimum_size.x = max_health * 10
