extends Area2D

var found : bool = false

@export var dialogue : String = "Placeholder"

func _ready():
	body_entered.connect(playerDetected)
	
func playerDetected(body):
	if body.is_in_group("Player") and not found:
		found = true
		EventBus.emit_signal("changeDialogue", dialogue)
		EventBus.emit_signal("completeGame")
	
