extends Camera2D

var player : CharacterBody2D

func _ready():
	player = get_tree().get_nodes_in_group("Player")[0]

func _physics_process(_delta):
	position.x = (round(player.position.x/320) * 320)
	position.y = (round(player.position.y/240) * 240)
