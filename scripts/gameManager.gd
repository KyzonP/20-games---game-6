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
	
	if Global.musicEnabled:
		$Soundtrack.play()
	
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
		
	if gameOver:
		if Input.is_action_just_pressed("dialogue"):
			get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
			
	if Input.is_action_just_pressed("mute_music"):
		if $Soundtrack.playing:
			$Soundtrack.stop()
		else:
			$Soundtrack.play()
			
	if Input.is_action_just_pressed("mute_sound"):
		Global.soundEnabled = not Global.soundEnabled
	
func completeGame():
	### END GAME CODE HERE ###
	gameOver = true
	Global.submitScores(timer, deaths)
	SaveLoad.save_game()
	
	
	
	
