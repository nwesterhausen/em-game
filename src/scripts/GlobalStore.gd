extends Node

# Game Settings
var SaveRev = 1;
var GameVersion = '0.0.1-alpha'
var debug = true;

## Spell Attributes ##
enum Elements {
	WATER,
	ICE,
	GROUND,
	FIRE,
	AIR,
	ELECTRIC,
	LIFE,
	NECROTIC,
	ARCANE   
   }
enum SpellTypes {
	BASIC,
	WALL,
	SIDE,
	AREA
   }
enum ProjectileWeights {
	V_LIGHT,
	LIGHT,
	NORMAL,
	HEAVY,
	V_HEAVY
   }

# Weight of basic spell impacts damage, cast speed, and projectile speed   
const basic_spell_weight = {
	Elements.WATER: ProjectileWeights.HEAVY,
	Elements.ICE: ProjectileWeights.NORMAL,
	Elements.FIRE: ProjectileWeights.LIGHT,
	Elements.GROUND: ProjectileWeights.HEAVY,
	Elements.AIR: ProjectileWeights.V_LIGHT,
	Elements.ELECTRIC: ProjectileWeights.LIGHT,
	Elements.LIFE: ProjectileWeights.NORMAL,
	Elements.NECROTIC: ProjectileWeights.V_HEAVY,
	Elements.ARCANE: ProjectileWeights.NORMAL
   }
const basic_speed = {
	ProjectileWeights.V_LIGHT: 600,
	ProjectileWeights.LIGHT: 500,
	ProjectileWeights.NORMAL: 400,
	ProjectileWeights.HEAVY: 300,
	ProjectileWeights.V_HEAVY: 200
}
const basic_cooldown_timer = {
	ProjectileWeights.V_LIGHT: .75,
	ProjectileWeights.LIGHT: 1,
	ProjectileWeights.NORMAL: 1.25,
	ProjectileWeights.HEAVY: 1.75,
	ProjectileWeights.V_HEAVY: 2.5
   }
const basic_damage_multiplier = {
	ProjectileWeights.V_LIGHT: 0.5,
	ProjectileWeights.LIGHT: 0.8,
	ProjectileWeights.NORMAL: 1,
	ProjectileWeights.HEAVY: 1.2,
	ProjectileWeights.V_HEAVY: 1.75
   }
   
# Area, line, and side spells cost mana gems to cast
const spell_cost = {
	SpellTypes.WALL: 1, 
	SpellTypes.SIDE: 2, 
	SpellTypes.AREA: 3
}
# Some side spells can be sustained at %mana per second
const side_spell_sustain_cost = {
	Elements.WATER: 0.04,
	Elements.AIR: 0.01,
}


## Colors ##
const c_debug_1 = '9C27B0';
const c_debug_2 = '00BCD4';
const c_disabled ='f44336';
const c_enabled = '4CAF50';

const element_colors = {
	Elements.WATER: "2196F3",
	Elements.ICE: "00BCD4",
	Elements.FIRE: "FF5722",
	Elements.GROUND: "795548",
	Elements.AIR: "9E9E9E",
	Elements.ELECTRIC: "FFEB3B",
	Elements.LIFE: "4CAF50",
	Elements.NECROTIC: "212121",
	Elements.ARCANE: "673AB7"
   }

## Scene Ref Dictionaries
var basic_atk_scenes = {
	Elements.WATER: "res://src/objects/spell_basic/water/basic.tscn",
	Elements.ICE: "res://Scenes/spells/ice/basic.tscn",
	Elements.FIRE: "res://src/objects/spell_basic/fire/basic.tscn",
	Elements.GROUND: "res://Scenes/spells/ground/basic.tscn",
	Elements.AIR: "res://Scenes/spells/air/basic.tscn",
	Elements.ELECTRIC: "res://Scenes/spells/electric/basic.tscn",
	Elements.LIFE: "res://Scenes/spells/life/basic.tscn",
	Elements.NECROTIC: "res://Scenes/spells/necrotic/basic.tscn",
	Elements.ARCANE: "res://Scenes/spells/arcane/basic.tscn"
   }

func _ready():
	# Try load version from VERSION file
	var file = File.new()
	var err = file.open('res://VERSION',File.READ)
	if err == OK:
		GameVersion = file.get_line()
		file.close()
	

