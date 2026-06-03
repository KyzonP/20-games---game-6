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
	
	if Global.showDeaths:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS ENABLED"
	else:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS DISABLED"
		
	if Global.showTimer: 
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER ENABLED"
	else:
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER DISABLED"

func startGame():
	get_tree().change_scene_to_file("res://levels/test.tscn")
	
func toggleTimer():
	Global.showTimer = not Global.showTimer
	
	if Global.showTimer: 
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER ENABLED"
	else:
		$VBoxContainer/TimerBox/RichTextLabel.text = "TIMER DISABLED"
	
func toggleDeaths():
	Global.showDeaths = not Global.showDeaths
	
	if Global.showDeaths:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS ENABLED"
	else:
		$VBoxContainer/DeathBox/RichTextLabel.text = "DEATHS DISABLED"
