extends StaticBody2D

var vanishTween : Tween

@export var vanishTime : float = 0.5

func _ready():
	$Area2D.body_entered.connect(collision)
	
	EventBus.restart.connect(reset)
	
func collision(_body):
	if vanishTween:
		vanishTween.kill()
	
	vanishTween = get_tree().create_tween()
	vanishTween.tween_property($Sprite2D, "modulate", Color(1,1,1,0), vanishTime)
	vanishTween.finished.connect(vanishComplete)
	
func vanishComplete():
	vanishTween.kill()
	vanishTween = null
	
	$SolidCollision.set_deferred("disabled", true)
	$Area2D.set_deferred("monitoring", false)

func reset():
	if vanishTween:
		vanishTween.kill()
		vanishTween = null

	$Sprite2D.modulate = Color(1,1,1,1)
	$SolidCollision.set_deferred("disabled", false)
	$Area2D.set_deferred("monitoring", true)
