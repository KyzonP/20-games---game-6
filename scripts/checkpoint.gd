extends Area2D

@export var flipped : bool = false

var active : bool = false

func _ready():
	body_entered.connect(collision)
	
	$Sprite2D.flip_v = flipped
	if flipped:
		$Sprite2D.position = Vector2(0,8)

func collision(body):
	if body.has_method("changeCheckpoint") and not active:
		body.changeCheckpoint(self)

func stop():
	$Sprite2D.play("idle")
	
	active = false
	
func start():
	if $Sprite2D.animation != "active":
		$Sprite2D.play("active")
		
		#Audio
		if Global.soundEnabled:
			$Checkpoint.play()
		
		active = true
