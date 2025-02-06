extends CharacterBody2D
class_name Enemy

func damage():
	self.queue_free()
