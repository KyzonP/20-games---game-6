extends Node
		
##### SAVE FUNCTIONS #####
func save():
	var save_dict = {
		"bestTime": Global.bestTime,
		"bestDeaths": Global.bestDeaths
	}
	return save_dict
	
func save_game():
	print("saving")
	var save_data= FileAccess.open("user://MM.save", FileAccess.WRITE)
	
	var json_string = JSON.stringify(save())
	
	save_data.store_line(json_string)
	
func load_data():
	if not FileAccess.file_exists("user://MM.save"):
		return
	
	var save_data = FileAccess.open("user://MM.save", FileAccess.READ)
	
	while save_data.get_position() < save_data.get_length():
		var json_string = save_data.get_line()
		var json=JSON.new()
		var _parse_result = json.parse(json_string)
		var node_data = json.get_data()
		
		for i in node_data.keys():
			if i=="bestTime":
				Global.bestTime = node_data[i]
			elif i == "bestDeaths":
				Global.bestDeaths = node_data[i]
