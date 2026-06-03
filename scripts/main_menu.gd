extends Control

func _ready():
	SaveLoad.load_data()
	
	if Global.bestTime == 999999999999999.99 or Global.bestDeaths == 999999999999999:
		pass
	else:	
		$HBoxContainer/TimerText.text = "Fastest Time: " + "%.2f" % Global.bestTime
		$HBoxContainer/DeathText.text = "Least Deaths: " + str(Global.bestDeaths)
		
	# Connect buttons
	$VBoxContainer/StartBox/RichTextLabel/Button.connect("button_down", startGame)
	$VBoxContainer/TimerBox/RichTextLabel/Button.connect("button_down",toggleTimer)
	$VBoxContainer/DeathBox/RichTextLabel/Button.connect("button_down",toggleDeaths)
	$VBoxContainer/MusicBox/RichTextLabel/Button.connect("button_down",toggleMusic)
	$VBoxContainer/SoundBox/RichTextLabel/Button.connect("button_down",toggleSound)
	
	if Global.showDeaths:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS ENABLED"
	else:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS DISABLED"
		
	if Global.showTimer: 
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER ENABLED"
	else:
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER DISABLED"

func startGame():
	#Audio
	$ClickSound.play()
	
	get_tree().change_scene_to_file("res://levels/test.tscn")
	
func toggleTimer():
	Global.showTimer = not Global.showTimer
	
	if Global.showTimer: 
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER ENABLED"
	else:
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER DISABLED"
		
	#Audio
	if Global.soundEnabled:
		$ClickSound.play()
	
func toggleDeaths():
	Global.showDeaths = not Global.showDeaths
	
	if Global.showDeaths:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS ENABLED"
	else:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS DISABLED"
		
	#Audio
	if Global.soundEnabled:
		$ClickSound.play()

func toggleMusic():
	Global.musicEnabled = not Global.musicEnabled
	
	if Global.musicEnabled:
		$Soundtrack.play()
	else:
		$Soundtrack.stop()
		
	if Global.musicEnabled:
		$VBoxContainer/MusicBox/RichTextLabel.text = "MUSIC ENABLED"
	else:
		$VBoxContainer/MusicBox/RichTextLabel.text = "MUSIC DISABLED"
		
	#Audio
	if Global.soundEnabled:
		$ClickSound.play()
		
	
func toggleSound():
	Global.soundEnabled = not Global.soundEnabled
	
	if Global.soundEnabled:
		$VBoxContainer/SoundBox/RichTextLabel.text = "SFX ENABLED"
	else:
		$VBoxContainer/SoundBox/RichTextLabel.text = "SFX DISABLED"
	
	#Audio
	if Global.soundEnabled:
		$ClickSound.play()
