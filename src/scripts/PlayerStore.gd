extends Node

# Player Attributes
var speed = 200;
var max_health = 10;
var health = 10;
var save_name = "Wizard"
var money = 0;

# Elements
var starting_gem = Global.Elements.WATER
var unlocked_gems = [];
var active_element = 0
var elemental_affinities = [0,3]
var spellbook = {}
var total_mana_gems = 4;

var player_mana_gem_elements = []
var player_mana_gem_charge = []


# Spell Casting
var targeting_side = false;
var targeting_wall = false;
var targeting_area = false;

var cooldowns = {
	Global.SpellTypes.BASIC: 0,
	Global.SpellTypes.WALL: 0,
	Global.SpellTypes.SIDE: 0,
	Global.SpellTypes.AREA: 0
   }

func _ready():
	# Initialize Mana Gems
	for _i in range(total_mana_gems):
		player_mana_gem_charge.push_back(1)
		player_mana_gem_elements.push_back(Global.Elements.WATER)
	populate_spellbook()
	

## Fills in spellbook with available spells after knowning what gems are
## available.
func populate_spellbook():
	pass;

# Marks a gem as obtained, requires starting_gem to be accurate
func unlock_gem(unlock):
	unlocked_gems.push_back(unlock);

# Turns the unlocked_gems array into a byte for storage
func pack_unlocked_gems():
	var unlocked_gems_byte = 0;
	
	var other_gems = [];
	for gem in Global.Elements:
		if Global.Elements[gem] != starting_gem:
			other_gems.push_back(Global.Elements[gem]);
	
	assert(other_gems.size() == 8, "Other gem list should be 8/9 possible gems.")
	var tval = 1;
	for i in range(8):
		if other_gems[i] in unlocked_gems:
			print("Adding %d to unlocked_gems" % tval)
			unlocked_gems_byte = unlocked_gems_byte + tval;
		print(str(other_gems[i])+" tval "+str(tval));
		tval = tval << 1;
	print("unlocked gems value: %d" % unlocked_gems_byte)
	return unlocked_gems_byte

# Uses a byte for unlocked gems and fills out the unlocked gem store
func unpack_unlocked_gems(unlocked_gems_byte):
	assert(typeof(unlocked_gems_byte) == TYPE_INT, "Unpack_unlocked_gems needs input as int");
	assert(unlocked_gems_byte < 256, "Unpack_unlocked_gems given too large of number, "+str(unlocked_gems_byte))
	if unlocked_gems.size() != 0:
		print ("Overwriting unlocked_gems from given byte")
		unlocked_gems.clear()
	var other_gems = [];
	for gem in Global.Elements:
		if Global.Elements[gem] != starting_gem:
			other_gems.push_back(Global.Elements[gem]);
	assert(other_gems.size() == 8, "Other gem list should be 8/9 possible gems.")
	for i in range(8):
		var mod_res = unlocked_gems_byte % 2
		print(str(unlocked_gems_byte)+" mod 2 = "+str(mod_res))
		if mod_res == 1:
			unlocked_gems.push_back(other_gems[i])
		unlocked_gems_byte = unlocked_gems_byte >> 1;
	print(unlocked_gems)

## Helper Functions
func reset_targeting_state():
	targeting_area = false;
	targeting_wall = false;
	targeting_side = false;
