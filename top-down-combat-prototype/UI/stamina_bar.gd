class_name StaminaBar extends ProgressBar
## Displays stamina of linked entity's [StaminaComponent].

## Reference to entity's [StaminaComponent].
@export var stamina_component: StaminaComponent

func _ready() -> void:
	stamina_component.connect("stamina_changed", Callable(self, "update_stamina_bar"))

## Updates [StaminaBar] value when [StaminaComponent] stamina is changed.
func update_stamina_bar(stamina: float) -> void:
	self.value = stamina
