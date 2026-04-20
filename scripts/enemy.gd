extends CharacterBody2D

@export var SPEED = 100
@export var always_load : bool = false
var GRAVITY = 150

var startPos : Vector2
var direction = 1

var alive : bool = true

@onready var ground_ray_cast = $GroundRaycast
@onready var front_ray_cast = $FrontRaycast

func _ready():
	startPos = global_position
	
	EventBus.restart.connect(reset)
	$DeathCheck.body_entered.connect(collision)
	$DeathCheck.area_entered.connect(collision)
	
	if always_load:
		self.process_mode = Node.PROCESS_MODE_ALWAYS
	
func _physics_process(delta):
	if alive:
		if front_ray_cast.is_colliding():
			flip()
			
		if not ground_ray_cast.is_colliding():
			flip()
			
			
		velocity.x = direction * SPEED
		velocity.y += GRAVITY
		move_and_slide()
	
func flip():
	direction *= -1
	ground_ray_cast.position.x *= -1
	front_ray_cast.position.x *= -1
	front_ray_cast.target_position *= -1
	
func die():
	alive = false
	$AnimatedSprite2D.modulate = Color(1,0,1,0)
	
func reset():
	global_position = startPos
	direction = 1
	
	ground_ray_cast.position.x = abs(ground_ray_cast.position.x)
	front_ray_cast.position.x = abs(front_ray_cast.position.x)
	front_ray_cast.target_position.x = abs(front_ray_cast.target_position.x)
	
	alive = true
	$AnimatedSprite2D.modulate = Color(1,0,1,1)
	
func collision(body):
	if body.is_in_group("Player"):
		EventBus.emit_signal("restart")
	elif body.is_in_group("Hazard"):
		die()
	pass
