extends Area2D

func _ready():
	body_entered.connect(collision)
	
func collision(_body):
	EventBus.emit_signal("restart")
