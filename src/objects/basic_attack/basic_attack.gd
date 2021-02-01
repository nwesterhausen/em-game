extends Area2D

export (Global.Elements) var element

var weight = Global.basic_spell_weight[element]
var target = GridController.tile_to_pos(GridController.mouse_tile);
var traj = Vector2();

func _ready():
	look_at(target);
	$Sprite.modulate = Color(Global.element_colors[element])
	traj = (target - global_position).normalized();
	print("pos: "+str(global_position)+" traj: "+str(traj))
	pass;

func _physics_process(delta):
	position += traj * Global.basic_speed[weight] * delta

func _on_Bullet_body_entered(_body):
	#if body.is_in_group("mobs"):
	#	body.queue_free()
	queue_free()
