extends Area2D

func _ready():
	body_entered.connect(collision)

func collision(body):
	if body.has_method("changeCheckpoint"):
		print("yeah")
		body.changeCheckpoint(self)
