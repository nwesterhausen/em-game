extends Node2D

var PlayerTscn = preload("res://src/actors/player/player.tscn")
var hud = {
	managems = preload("res://src/hud/mana_gems.tscn")
}
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var H_managems = hud.managems.instance()
	add_child(H_managems)
	
	var hud_nodes = {
		'managems': H_managems
	}
	
	var Player = PlayerTscn.instance();
	add_child(Player);
	Player.set_hud(hud_nodes)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
