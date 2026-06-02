extends CharacterBody2D

@export var SPEED : float = 100.0
@export var always_load : bool = false
@export var flipped : bool = false

var GRAVITY = 150

var startPos : Vector2
var direction = 1

var alive : bool = true

@onready var ground_ray_cast = $GroundRaycast
@onready var front_ray_cast = $FrontRaycast

func _ready():
	if flipped:
		GRAVITY *= -1
		$GroundRaycast.target_position *= -1
		$FrontRaycast.target_position *= -1
		$AnimatedSprite2D.flip_v = true
		$AnimatedSprite2D.position = Vector2(0,4)
	
	startPos = global_position
	
	EventBus.restart.connect(reset)
	$DeathCheck.body_entered.connect(collision)
	$DeathCheck.area_entered.connect(collision)
	
	if always_load:
		self.process_mode = Node.PROCESS_MODE_ALWAYS
		
	$AnimatedSprite2D.speed_scale = SPEED/100
	
func _physics_process(_delta):
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
	$AnimatedSprite2D.flip_h = !$AnimatedSprite2D.flip_h
	
func die():
	alive = false
	$AnimatedSprite2D.modulate = Color(1,0,1,0)
	
func reset():
	global_position = startPos
	direction = 1
	
	ground_ray_cast.position.x = abs(ground_ray_cast.position.x)
	front_ray_cast.position.x = abs(front_ray_cast.position.x)
	front_ray_cast.target_position.x = abs(front_ray_cast.target_position.x)
	
	$AnimatedSprite2D.flip_h = false
	
	alive = true
	
func collision(body):
	if body.is_in_group("Player"):
		EventBus.emit_signal("restart")
	elif body.is_in_group("Hazard"):
		die()
	pass
