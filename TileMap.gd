extends TileMap

onready var map = preload("res://map2.tscn")
var temptiles = self.get_used_cells_by_id(1)
var starttiles = self.get_used_cells_by_id(2)
var Tree = preload("res://Tree.tscn")
var Dew = preload("res://Dew.tscn")
var Bluebell = preload("res://Tree.tscn")
func _ready():
	Engine.time_scale = 1 # .5 = game ticks at half speed, 2 = game ticks and double speed
	clear()
#	load map here instead of above; map selection here?
	var map2 = map.instance()
	temptiles = map2.get_used_cells_by_id(1)
	starttiles = map2.get_used_cells_by_id(2)
	
	
func _on_tick_timeout():
	var adjacenttiles = []
	for tile in self.get_used_cells_by_id(2):
		#fix this shit lmao
		if not adjacenttiles.has(tile + Vector2(0,1)) and not get_cellv(tile + Vector2(0,1)) == -1:
			adjacenttiles.append(tile + Vector2(0,1))
		if not adjacenttiles.has(tile + Vector2(1,0)) and not get_cellv(tile + Vector2(1,0)) == -1:
			adjacenttiles.append(tile + Vector2(1,0))
		if not adjacenttiles.has(tile + Vector2(-1,0)) and not get_cellv(tile + Vector2(-1,0)) == -1:
			adjacenttiles.append(tile + Vector2(-1,0))
		if not adjacenttiles.has(tile + Vector2(0,-1)) and not get_cellv(tile + Vector2(0,-1)) == -1:
			adjacenttiles.append(tile + Vector2(0,-1))
		set_cellv(tile, -1)
	
	for tile in adjacenttiles:
		set_cellv(tile, 2)

func _on_islandstart_timeout():
	if temptiles.size() > 0:
		set_cellv(temptiles.back(), 1)
		temptiles.remove(temptiles.size()-1)
	elif starttiles.size() > 0:
			set_cellv(starttiles.back(), 2)
			starttiles.remove(starttiles.size()-1)
	else:
		$"islandstart".stop()
		$"tick".start()
	pass # Replace with function body.


func _input(event):
	if event.is_action_pressed("mouse_left_click"):
		var clickposition = map_to_world(world_to_map(get_local_mouse_position()))
		
		var t = Tree.instance()
		t.position = clickposition
		$YSort.add_child(t)
#		set_cellv(world_to_map(get_local_mouse_position()), 2)
	elif event is InputEventMouseMotion:
		$Sprite.position =  map_to_world(world_to_map(get_local_mouse_position()))

#create signal/function from where children plants call to add grass
