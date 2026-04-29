extends TileMapLayer

# Enabled by any children who are set to always be active
var alwaysActiveChild : bool = false

func enable():
	if not alwaysActiveChild:
		visible = true
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		self_modulate.a = 1
		process_mode = Node.PROCESS_MODE_INHERIT
		
		for child in get_children():
			if "alwaysActive" in child:
				if not child.alwaysActive:
					child.visible = true
			else:
				child.visible = true
	
func disable():
	if not alwaysActiveChild:
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED
	else:
		self_modulate.a = 0
		process_mode = Node.PROCESS_MODE_DISABLED
		
		for child in get_children():
			if "alwaysActive" in child:
				if not child.alwaysActive:
					child.visible = false
			else:
				child.visible = false
