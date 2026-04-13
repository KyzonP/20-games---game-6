extends AnimatableBody2D

@export var speed : float = 100.0
@export var desp : float = 200.0
var direction : Vector2 = Vector2.RIGHT
var init_x := 0.0
var forward : bool = true

func _ready():
	# Sync movement with physics engine
	init_x = position.x
	sync_to_physics = true
	
	# Connect reset signal
	EventBus.restart.connect(reset)
	
func _physics_process(delta):
	# Calculate movement amount for frame
	var movement : Vector2 = direction * speed * delta
	
	# Update position
	position += movement
	
	# Reverse direction at certain thresholds
	if forward:
		if position.x >= init_x + desp:
			direction *= -1
			forward = false
	else:
		if position.x <= init_x - desp:
			direction *= -1
			forward = true
			
func reset():
	position.x = init_x
	forward = true
	direction = Vector2.RIGHT
