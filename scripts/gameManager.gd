extends Node2D

var progress : int = 0
var exitOpened : bool = false

var gameOver : bool = false

var deaths : int = 0
var timer : float = 0.0

func _ready():
	EventBus.completeGame.connect(completeGame)
	EventBus.progress.connect(progressLevel)
	EventBus.restart.connect(reset)
	EventBus.smallRestart.connect(reset)
	
func progressLevel():
	progress = progress + 1
	if progress >= 4 and not exitOpened:
		openExit()

func openExit():
	exitOpened = true
	
	$Exit.remove()
	
func reset():
	deaths += 1
	print(deaths)
	
func _physics_process(delta):
	if not gameOver:
		timer += delta
	
func completeGame():
	### END GAME CODE HERE ###
	gameOver = true
	
	#EventBus.emit_signal("changeDialogue","Press Escape to return to main menu")
	
