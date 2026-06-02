extends Node

var showTimer : bool = false
var showDeaths : bool = false

var bestTime : float = 0.0
var bestDeaths : int = 0

func submitScores(time, deaths):
	if time < bestTime:
		bestTime = time
	if deaths < bestDeaths:
		bestDeaths = deaths
		
	SaveLoad.save_game()
