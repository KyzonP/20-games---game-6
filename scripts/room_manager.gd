extends Node2D

@export var room_width = 320
@export var room_height = 240

var room_grid = {}
var current_grid_pos = Vector2i(-999,-999)

var active_rooms : Array[Vector2i] = []

func _ready():
	# Catalog all rooms
	for child in get_children():
		if child is TileMapLayer:
			var grid_x = roundi(child.global_position.x / room_width)
			var grid_y = roundi(child.global_position.y / room_height)
			var coords = Vector2i(grid_x, grid_y)
			
			room_grid[coords] = child
			disable_room(child)
			
func _physics_process(_delta):
	# check player pos
	var player_pos = get_tree().get_first_node_in_group("Player").global_position
	var px = roundi(player_pos.x / room_width)
	var py = roundi(player_pos.y / room_height)
	var new_grid_pos = Vector2i(px,py)
	
	# Compare current grid position with last recorded one
	if new_grid_pos != current_grid_pos:
		update_active_grid(new_grid_pos)
		current_grid_pos = new_grid_pos
	
func update_active_grid(center_pos : Vector2i):
	# Check which rooms should be active
	var target_coords = [
		center_pos,
		center_pos + Vector2i.UP,
		center_pos + Vector2i.DOWN,
		center_pos + Vector2i.LEFT,
		center_pos + Vector2i.RIGHT
	]
	
	# disable rooms that were active but aren't meant to be now
	for i in range(active_rooms.size() - 1, -1, -1):
		var coord = active_rooms[i]
		if coord not in target_coords:
			if room_grid.has(coord):
				disable_room(room_grid[coord])
			active_rooms.remove_at(i)
	
	# enable rooms that aren't active but should be
	for coord in target_coords:
		if coord not in active_rooms:
			if room_grid.has(coord):
				enable_room(room_grid[coord])
				active_rooms.append(coord)
				
	# Reset things inside the room being entered
	if room_grid.has(center_pos):
		reset_room(room_grid[center_pos])
		
func reset_room(room):
	for child in room.get_children():
		if child.has_method("reset"):
			child.reset()
	
func enable_room(room):
	if room.has_method("enable"):
		room.enable()
	else:
		room.visible = true
		room.process_mode = Node.PROCESS_MODE_INHERIT
	
func disable_room(room):
	if room.has_method("disable"):
		room.disable()
	else:
		room.visible = false
		room.process_mode = Node.PROCESS_MODE_DISABLED
