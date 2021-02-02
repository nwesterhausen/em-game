extends Node2D

var PlayerTscn = preload("res://src/actors/player/player.tscn")
var hud = {
    'managems' : preload("res://src/hud/mana_gems.tscn"),
    'status' : preload("res://src/hud/health_and_status.tscn"),
}

func _ready():
    var H_managems = hud.managems.instance()
    add_child(H_managems)
    var H_status = hud.status.instance()
    add_child(H_status)
    
    var hud_nodes = {
        'managems': H_managems,
        'status': H_status,
    }
    
    var Player = PlayerTscn.instance();
    add_child(Player);
    Player.set_hud(hud_nodes)
