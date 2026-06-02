extends Area2D

@export var side : bool = false
@export var flipped : bool = false

func _ready():
	body_entered.connect(collision)
	
	if side:
		$Sprite2D.texture = load("res://assets/hazard/SideSpike.png")
	else:
		$Sprite2D.flip_v = flipped
	
func collision(body):
	if body.has_method("die") and not body.is_dead:
		body.die()
			
