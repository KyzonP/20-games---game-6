extends CharacterBody2D

@export var active : bool = true

var GRAVITY = 18000
const SPEED = 100

@onready var anim = $AnimatedSprite2D

@export var checkpoint : Area2D = null

var is_dead : bool = false

func _ready():
	EventBus.restart.connect(reset)
	EventBus.smallRestart.connect(reset)
	EventBus.freeze.connect(freeze)
	EventBus.unfreeze.connect(unfreeze)

func _physics_process(delta):
	if active:
		get_movement(delta)
		
		move_and_slide()
	
func get_movement(delta):
	# move_up and move_down aren't actually things
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	velocity.y += GRAVITY * delta
	
	if velocity.x == 0:
		$AnimatedSprite2D.animation = "idle"
	elif velocity.x > 0:
		$AnimatedSprite2D.animation = "walk"
		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = false
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "walk"
		if !$AnimatedSprite2D.is_playing():
			$AnimatedSprite2D.play()
		$AnimatedSprite2D.flip_h = true
	
func _input(event):
	if event.is_action_pressed("flip_gravity"):
		if is_on_floor():
			flip_gravity()
			
			#Audio
			if Global.soundEnabled:
				$Jump.play()
		
func flip_gravity():
	up_direction *= -1
	GRAVITY *= -1
	anim.flip_v = !anim.flip_v
	if up_direction == Vector2(0,-1):
		$AnimatedSprite2D.position = Vector2(0,-5)
	else:
		$AnimatedSprite2D.position = Vector2(0,5)
	
func changeCheckpoint(body):
	if body is Area2D:
		checkpoint.stop()
		
		checkpoint = body
		
		checkpoint.start()

func reset():
	self.global_position = checkpoint.global_position
	anim.flip_v = checkpoint.flipped
	if not checkpoint.flipped:
		up_direction = Vector2(0,-1)
		GRAVITY = abs(GRAVITY)
		$AnimatedSprite2D.position = -abs($AnimatedSprite2D.position)
	else:
		up_direction = Vector2(0,1)
		GRAVITY = abs(GRAVITY) * -1
		$AnimatedSprite2D.position = abs($AnimatedSprite2D.position)
		
	is_dead = false
	
func freeze():
	active = false
	$AnimatedSprite2D.play("idle")
	
func unfreeze():
	active = true
	
func die():
	if is_dead:
		return
	is_dead = true
	
	#Audio
	if Global.soundEnabled:
		$Death.play()
	
	EventBus.emit_signal.call_deferred("smallRestart")
