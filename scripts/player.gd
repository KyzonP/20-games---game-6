extends CharacterBody2D

var GRAVITY = 150
const SPEED = 100

@onready var anim = $AnimatedSprite2D

@export var checkpoint : Area2D = null

func _ready():
	EventBus.restart.connect(reset)

func _physics_process(_delta):
	get_input()
	
	move_and_slide()
	
func get_input():
	# move_up and move_down aren't actually things
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * SPEED
	velocity.y += GRAVITY
	
func _input(event):
	if event.is_action_pressed("flip_gravity"):
		if is_on_floor():
			flip_gravity()
		
func flip_gravity():
	up_direction *= -1
	GRAVITY *= -1
	anim.flip_v = !anim.flip_v
	
func changeCheckpoint(body):
	if body is Area2D:
		checkpoint = body

func reset():
	self.global_position = checkpoint.global_position
	up_direction = Vector2(0,-1)
	GRAVITY = abs(GRAVITY)
