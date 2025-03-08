extends ProgressBar

@export var attack_selector: ChargeState

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	self.value = attack_selector.hold_length
