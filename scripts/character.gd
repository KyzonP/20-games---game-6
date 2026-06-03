extends Area2D

var found : bool = false

@export var dialogue : String = "Placeholder"

@export var shelah : bool = false
@export var shelahDialogue : String = "Placeholder"

func _ready():
	body_entered.connect(playerDetected)
	
func playerDetected(body):
	if body.is_in_group("Player") and not found:
		if shelah and get_parent().progress == 3:
			dialogue = shelahDialogue
		
		found = true
		EventBus.emit_signal("changeDialogue", dialogue)
		EventBus.emit_signal("progress")
		
		$Sprite2D.visible = false
		
		#Audio
		if Global.soundEnabled:
			$Speak.play()
	
