extends Area2D

@export var flipped : bool = false

func _ready():
	body_entered.connect(collision)
	
	$Sprite2D.flip_v = flipped

func collision(body):
	if body.has_method("changeCheckpoint"):
		print("yeah")
		body.changeCheckpoint(self)
