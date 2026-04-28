extends Node2D

var moveTween : Tween
var initPos : Vector2
var finalPos : Vector2

@export var moveTime : float = 1.0

@export var alwaysActive : bool = false

func _ready():
	# Sync movement with physics engine
	initPos = $Moving_Platform.position
	finalPos = $EndPos.position
	$Moving_Platform.sync_to_physics = true
	
	# Hide the 'End Pos' sprite
	$EndPos/Sprite2D.visible = false
	
	# Connect reset signal
	EventBus.restart.connect(reset)
	
	# Connect death signal
	$Moving_Platform/DeathZone.body_entered.connect(collision)
	
	# Start the tween
	start()
	
	# Tell parent we're always active
	if alwaysActive:
		process_mode = Node.PROCESS_MODE_ALWAYS
		if "alwaysActiveChild" in get_parent():
			get_parent().alwaysActiveChild = true
			
func reset():
	$Moving_Platform.sync_to_physics = false
	$Moving_Platform.position = initPos

	if moveTween:
		moveTween.kill()
		moveTween = null
		
	$Moving_Platform.sync_to_physics = true
		
	start()
	
func start():
	moveTween = get_tree().create_tween()
	moveTween.tween_property($Moving_Platform, "position", finalPos, moveTime)
	moveTween.finished.connect(flip)
	
func flip():
	moveTween = get_tree().create_tween()
	moveTween.tween_property($Moving_Platform, "position", initPos, moveTime)
	moveTween.finished.connect(start)
	
func collision(body):
	if body.is_in_group("Player"):
		EventBus.emit_signal("restart")
