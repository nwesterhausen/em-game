extends Node
# This script is a singletone which is meant to control the game grid.
# Tiles are represented with a Vector2(tileX, tileY) where the tileX and Y are
# integers. Right now, the "debug" background grid is drawn just over the screen
# size, but technically the conversions and storing (and drawing the highlights)
# should work for even negative tiles or tiles beyond the "border".

# Background (debug?) grid color
var grid_color = Color8(0, 0, 0, 100);
# Space between grid lines
var gdelta = 24;
var gsize_vector = Vector2(gdelta, gdelta);

## Global Tile Position Stores ##
var mouse_tile = Vector2(0,0); # tile mouse is over
var player_tile = Vector2(11,5); # tile player is mostly-over
# Tile array for horizontal spell targeting, usually 1x3 or 3x1
var wall_target = [player_tile];
# Tile array for side spell targeting, usually 1x3 or 3x1, starts from player
var side_target = [player_tile];
# Tile array for area spell targeting, usually 3x3
var area_target = [player_tile];

# Vectors to modify side attack area
var side_modify_vec = [
	Vector2(0,-2),Vector2(2,0),Vector2(0,2),Vector2(-2,0)
];

# Create grid collision shape
var GridShape = RectangleShape2D.new();

func _ready():
	GridShape.set_extents(gsize_vector);

## Global Helper Functions ##
# Given a position vector will return a vector for the tile position it is in.
func pos_to_tile(pos_vector):
	var tilev = Vector2(int(pos_vector[0]/gdelta),int(pos_vector[1]/gdelta));
	return tilev;

# Uses the grid size to convert a tile vector into a position (x,y) for the 
# top-left corner of that tile.
func tile_to_pos(tile_vector):
	var posv = Vector2(tile_vector[0]*gdelta, tile_vector[1]*gdelta);
	return posv;

# Given a position vector, returns a rectangle for a single grid square for that
# position.
func pos_to_rec(pos_vector):
	var grec = Rect2(pos_vector, gsize_vector);
	return grec;

func tile_to_rec(tile_array):
	# Handle being passed a single tile Vector instead of an array
	if typeof(tile_array) == TYPE_VECTOR2:
		tile_array = [tile_array];
	# Before continuing, assert that we have an array with stuff in it
	assert(typeof(tile_array) == TYPE_ARRAY, "ERROR: multitile_to_rec expects a single Vector2 tile or an array of Vector2 tiles")
	assert(tile_array.size() > 0, "ERROR: must be given a non-empty tile_array")
	# Shortcut if tile_arrary is just 1 (or 0) in size
	if tile_array.size() == 1:
		return pos_to_rec(tile_to_pos(tile_array[0]));
	# Default position to first tile in array
	var tl_pos = tile_to_pos(tile_array[0]);
	var br_pos = Vector2(0,0);
	# Loop over every tile in the array. For each tile, grab the position
	# of the tile and compare the upper left corner (how we return the 
	# position here) to set the rectangle pos (rpos) to be the most upper
	# and most left points among all the tiles in the array.
	#
	# Then calculate the width by adding the grid size to the distance between
	# the current tile in the array's left-most point and our rectangles left-
	# most point. Same thing with the height. This could allow to draw a
	# rectangle over an array of diagonal tiles, or just an top left corner and
	# bottom right corner.
	for i in range (tile_array.size()):
		var ipos = tile_to_pos(tile_array[i]);
		if ipos[0] < tl_pos[0]: # Is this tile more left than what we stored?
			tl_pos[0] = ipos[0];
		elif ipos[0] >= br_pos[0]: # Is this more right than our bottom corner?
			br_pos[0] = ipos[0];
		if ipos[1] < tl_pos[1]: # Is this tile more up than what we stored?
			tl_pos[1] = ipos[1];
		elif ipos[1] >= br_pos[1]: # Is this more down than our bottom corner?
			br_pos[1] = ipos[1];
	
	# Size is equal to the most bottom right top-left corner position minus the
	# most top left top-left corner position plus the grid size.
	var rsize = br_pos - tl_pos + gsize_vector;        
	var mtrec = Rect2(tl_pos, rsize);
	return mtrec;

# Take a single tile and return an array of tile vectors hlen x vlen centered 
# on the given tile. Used to make the line targeter and area targeter.
func tile_to_array(tile_vector, hlen=1, vlen=1):
	# Can't allow 0 or negative values for dimensions.
	if hlen < 1:
		hlen = 1;
	if vlen < 1:
		vlen = 1;
	
	if hlen == vlen && vlen == 1:
		# For some reason, this was called with a 1 dimensioned line on
		# both dimensions. Return an array with the starting tile only.
		# This *would* get returned by the logic below, but maybe it's
		# better just to return it here :) 
		return [tile_vector];
	
	var tile_array = [];
	
	# Centered lines are what we want. Using a half var, we center on the tile.
	var hcenter = int(hlen / 2);
	var vcenter = int(vlen / 2);
	
	for i in range (hlen):
		var hdiff = i - hcenter; # hdiff is how far away from center is this column
		for j in range (vlen):
			var vdiff = j - vcenter; # vdiff is how far away from center is this row
			
			# Add a tile to the array in relative position (hdiff, vdiff)
			tile_array.push_front(tile_vector + Vector2(hdiff, vdiff))
	
	return tile_array;


# Cardinal Directions:
#   0: North
#   1: East
#   2: South
#   3: West
# Gives an approx direction between two tiles
func cardinal_direction_from(vec1, vec2):
	# Approximate for the side targeting, just need to roughly decide N,S,E,W
	var vdiff = vec1.y - vec2.y;
	var hdiff = vec1.x - vec2.x;
	if abs(vdiff) > abs(hdiff): #more vertical diff
		if vdiff < 0: #vec1 above
			return 2;
		else:
			return 0;
	else: #more horizontal diff
		if hdiff < 0: #vec1 left
			return 1;
		else:
			return 3;
