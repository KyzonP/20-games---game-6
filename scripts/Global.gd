extends Node

var showTimer : bool = false
var showDeaths : bool = false

var bestTime : float = 999999999999999.99
var bestDeaths : int = 999999999999999

func submitScores(time, deaths):
	if time < bestTime:
		bestTime = time
	if deaths < bestDeaths:
		bestDeaths = deaths
		
	SaveLoad.save_game()
