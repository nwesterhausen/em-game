extends Node2D

var current_screen
var fps

var screens = {
	"main_menu": preload("res://src/screens/main_menu.tscn"),
	"controls": preload("res://src/screens/controls.tscn"),
	"game": preload("res://src/screens/test_area.tscn"), #TESTING MODE
	"credits": preload("res://src/screens/credits.tscn"),
	"debug_menu": preload("res://src/screens/debug_menu.tscn"),
   }

func _ready():
	set_process_input(true)
	set_process(true)
	current_screen = find_node("screen")
	fps = find_node("fps")
	load_screen("main_menu")
	find_node("version").set_text("v%s" % Global.GameVersion)
	
func _input(event):
	if event.is_action_pressed("ui_toggle_fps"):
		fps.set_hidden(!fps.is_hidden())
	if event.is_action_pressed("ui_debug_toggle"):
		Global.debug = !Global.debug
		
func _process(delta):
	fps.set_text("FPS: %d" % Performance.get_monitor(Performance.TIME_FPS))
	# Update Mouse tile position
	GridController.mouse_tile = GridController.pos_to_tile(get_viewport().get_mouse_position());
	
	GridController.area_target = GridController.mouse_tile;
	GridController.wall_target = GridController.mouse_tile;
	GridController.side_target = GridController.mouse_tile;
	
	# Update possible targeting areas' positions
	if PlayerStore.targeting_area:
		GridController.area_target = GridController.tile_to_array(GridController.mouse_tile, 3, 3);
	if PlayerStore.targeting_side:
		var side_dir = GridController.cardinal_direction_from(GridController.player_tile, GridController.mouse_tile);
		if side_dir == 0 || side_dir == 2:
			GridController.side_target = GridController.tile_to_array((GridController.player_tile + GridController.side_modify_vec[side_dir]),1,3)
		else:
			GridController.side_target = GridController.tile_to_array((GridController.player_tile + GridController.side_modify_vec[side_dir]),3,1)
		
func load_screen(name):
	if name in screens:
		var old_screen = null
		if current_screen.get_child_count() > 0:
			old_screen = current_screen.get_child(0)
		if old_screen != null:
			current_screen.remove_child(old_screen)

		var new_screen = screens[name].instance()
		current_screen.add_child(new_screen)
	else:
		print("[ERROR] Cannot load screen: ", name)
