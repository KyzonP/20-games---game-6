extends Node2D

var progress : int = 0
var exitOpened : bool = false

func _ready():
	EventBus.completeGame.connect(completeGame)
	EventBus.progress.connect(progressLevel)
	
func progressLevel():
	progress = progress + 1
	if progress >= 4 and not exitOpened:
		openExit()

func openExit():
	exitOpened = true
	
	### OPEN EXIT CODE HERE ###
	
func completeGame():
	### END GAME CODE HERE ###
	
	pass
