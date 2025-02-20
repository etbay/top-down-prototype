class_name StaminaBar extends ProgressBar
## Displays stamina of linked entity's [StaminaComponent].

## Reference to entity's [StaminaComponent].
@export var stamina_component: StaminaComponent

func _ready() -> void:
	# Listen for changes
	stamina_component.connect("stamina_changed", Callable(self, "update_stamina_bar"))
	stamina_component.connect("max_stamina_changed", Callable(self, "update_stamina_bar_size"))
	
	# Initialize bar
	self.max_value = stamina_component.max_stamina
	self.custom_minimum_size.x = stamina_component.max_stamina * 10

## Updates [StaminaBar] value when [StaminaComponent] stamina is changed.
func update_stamina_bar(stamina: float) -> void:
	self.value = stamina

## Updates [StaminaBar] size when [StaminaComponent] max stamina is changed.
func update_stamina_bar_size(max_stamina: float) -> void:
	self.max_value = max_stamina
	self.custom_minimum_size.x = max_stamina * 10
